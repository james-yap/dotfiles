-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local manim = require("utils.manim")
local terminal = require("utils.terminal")

map("n", "<leader>cp", function()
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

map("n", "<leader>tt", function()
  terminal.open_buffer_job(vim.o.shell, { start_insert = true })
end, { desc = "Open terminal buffer" })

map("n", "<leader>mr", manim.render_scene, { desc = "Render current Manim scene" })
map("n", "<leader>ms", manim.render_slides, { desc = "Render current Manim scene (manim-slides)" })
map("n", "<leader>mp", manim.present_scene, { desc = "Present current Manim scene" })
map("n", "<leader>mo", manim.open_scene_output, { desc = "Open output directory for current scene" })
