-- ~/.config/nvim/lua/plugins/diffview.lua
return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    -- To disable command-line completion for Diffview commands (highly recommended in massive monoliths
    -- like shop/world to prevent Neovim from freezing or running expensive Git queries):
    -- Uncomment the config block below.
    --
    -- Example use case for DiffviewOpen (for future reference):
    -- :DiffviewOpen main...pr-feature-branch -- . ':!**/tests/**' ':!**/translations/**'
    --
    -- config = function(_, opts)
    --   require("diffview").setup(opts)
    --
    --   local diffview = require("diffview")
    --
    --   diffview.completers.DiffviewOpen = function()
    --     return {}
    --   end
    --
    --   diffview.completers.DiffviewFileHistory = function()
    --     return {}
    --   end
    -- end,
  },
}
