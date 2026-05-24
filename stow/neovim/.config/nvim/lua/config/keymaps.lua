-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>cp", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("Copied: " .. path)
end, { desc = "Copy current file path" })

local ok, wk = pcall(require, "which-key")
if ok then
  wk.add({
    { "<leader>m", group = "manim" },
    { "<leader>t", group = "terminal" },
  })
end

vim.keymap.set("n", "<leader>tt", function()
  vim.cmd("tabnew")
  vim.fn.jobstart(vim.o.shell, { term = true })
  vim.cmd("startinsert")
end, { desc = "Open terminal in new tab" })

vim.keymap.set("n", "<leader>ms", function()
  local file = vim.fn.expand("%:p")

  if vim.bo.filetype ~= "python" then
    vim.notify("Manim Slides: current buffer is not a Python file", vim.log.levels.WARN)
    return
  end

  local scene_class = nil
  for lnum = vim.fn.line("."), 1, -1 do
    local line = vim.fn.getline(lnum)
    local class_name = line:match("^%s*class%s+([%w_]+)%s*[%(:]")
    if class_name then
      scene_class = class_name
      break
    end
  end

  if not scene_class then
    vim.notify("Manim Slides: no enclosing class found", vim.log.levels.WARN)
    return
  end

  local root = vim.fs.root(file, { "pyproject.toml", ".git" }) or vim.fn.getcwd()
  local cmd = table.concat({
    "uv run manim-slides render",
    vim.fn.shellescape(file),
    vim.fn.shellescape(scene_class),
    "-ql",
    "&& uv run manim-slides present",
    vim.fn.shellescape(scene_class),
  }, " ")

  vim.cmd("tabnew")
  vim.fn.jobstart(cmd, { cwd = root, term = true })
  -- vim.cmd("startinsert") -- focuses the terminal
end, { desc = "Render/present current Manim Slides scene" })
