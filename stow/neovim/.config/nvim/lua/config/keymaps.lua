-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local manim = require("utils.manim")
local terminal = require("utils.terminal")

map({ "n", "x" }, "<leader>cp", function()
  local path = vim.fn.expand("%:p")
  local result

  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" or mode == "\22" then
    local s = vim.fn.getpos("v")
    local e = vim.fn.getpos(".")
    local srow, scol = s[2], s[3]
    local erow, ecol = e[2], e[3]
    -- normalize so the start position precedes the end position
    if srow > erow or (srow == erow and scol > ecol) then
      srow, scol, erow, ecol = erow, ecol, srow, scol
    end
    if mode == "V" then
      result = string.format("%s:L%d-L%d", path, srow, erow)
    elseif srow == erow then
      result = string.format("%s:L%d:C%d-C%d", path, srow, scol, ecol)
    else
      result = string.format("%s:L%d:C%d-L%d:C%d", path, srow, scol, erow, ecol)
    end
  else
    -- no selection: single character position at the cursor
    local c = vim.fn.getpos(".")
    result = string.format("%s:L%d:C%d", path, c[2], c[3])
  end

  vim.fn.setreg("+", result)
  print("Copied: " .. result)
end, { desc = "Copy current file path (with range/position)" })

map("n", "<leader>cP", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("Copied: " .. path)
end, { desc = "Copy current file path" })

-- Copy whatever <leader>at (sidekick "Send This") would send to the agent,
-- but put it on the system clipboard instead of sending it to a CLI session.
-- map({ "n", "x" }, "<leader>at", function()
--   local ok, cli = pcall(require, "sidekick.cli")
--   if not ok then
--     vim.notify("sidekick.nvim is not available", vim.log.levels.ERROR)
--     return
--   end
--   local msg = cli.render({ msg = "{this}" })
--   if not msg or msg == "" or msg == "\n" then
--     vim.notify("Nothing to copy", vim.log.levels.WARN)
--     return
--   end
--   vim.fn.setreg("+", msg)
--   vim.notify("Copied sidekick context to clipboard", vim.log.levels.INFO)
-- end, { desc = "Copy sidekick context (this) to clipboard" })

local ok, wk = pcall(require, "which-key")
if ok then
  wk.add({
    { "<leader>m", group = "manim" },
    { "<leader>t", group = "terminal" },
  })
end

map("n", "<leader>tt", function()
  terminal.open_buffer_job(vim.o.shell, { start_insert = true })
end, { desc = "Open terminal buffer" })

map("n", "<leader>mr", manim.render_scene, { desc = "Render current Manim scene" })
map("n", "<leader>ms", manim.render_slides, { desc = "Render current Manim scene (manim-slides)" })
map("n", "<leader>mp", manim.present_scene, { desc = "Present current Manim scene" })
map("n", "<leader>mo", manim.open_scene_output, { desc = "Open output directory for current scene" })
