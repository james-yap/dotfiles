local terminal = require("utils.terminal")

local M = {}

local function shell_join(parts)
  local escaped = {}

  for _, part in ipairs(parts) do
    escaped[#escaped + 1] = vim.fn.shellescape(part)
  end

  return table.concat(escaped, " ")
end

local function notify(message)
  vim.notify("Manim: " .. message, vim.log.levels.WARN)
end

local function enclosing_class()
  for lnum = vim.fn.line("."), 1, -1 do
    local line = vim.fn.getline(lnum)
    local class_name = line:match("^%s*class%s+([%w_]+)%s*[%(:]")

    if class_name then
      return class_name
    end
  end

  notify("no enclosing class found")
end

local function context()
  local file = vim.fn.expand("%:p")
  local file_name = vim.fn.expand("%:t:r") -- strips ".py" extension

  if vim.bo.filetype ~= "python" then
    notify("current buffer is not a Python file")
    return
  end

  local scene_class = enclosing_class()
  if not scene_class then
    return
  end

  return {
    file = file,
    file_name = file_name,
    scene_class = scene_class,
    root = vim.fs.root(file, { "pyproject.toml", ".git" }) or vim.fn.getcwd(),
  }
end

local function run(command_parts)
  local ctx = context()
  if not ctx then
    return
  end

  terminal.open_buffer_job(shell_join(command_parts(ctx)), { cwd = ctx.root })
  -- vim.cmd("startinsert") -- focuses the terminal
end

function M.render_scene()
  run(function(ctx)
    return { "uv", "run", "manim", ctx.file, ctx.scene_class }
  end)
end

function M.render_slides()
  run(function(ctx)
    return { "uv", "run", "manim-slides", "render", ctx.file, ctx.scene_class }
  end)
end

function M.present_scene()
  run(function(ctx)
    return { "uv", "run", "manim-slides", "present", ctx.scene_class }
  end)
end

function M.open_scene_output()
  local ctx = context()
  if not ctx then
    return
  end

  local output = vim.fs.joinpath(ctx.root, "media", "videos", ctx.file_name)
  local job_id = vim.fn.jobstart({ "open", output }, { cwd = ctx.root, detach = true })

  if job_id <= 0 then
    notify("failed to open scene output")
  end
end

return M
