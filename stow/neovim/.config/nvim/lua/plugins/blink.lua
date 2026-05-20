return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      opts.sources.providers = opts.sources.providers or {}

      opts.sources.providers.morgan_snip = {
        name = "Morgan Snip",
        module = "morgan_snip",
        min_keyword_length = 0,
      }

      opts.keymap = opts.keymap or {}

      opts.keymap["<C-s>"] = {
        function(cmp)
          cmp.show({
            providers = { "morgan_snip" },
          })
        end,
      }

      opts.keymap["<C-n>"] = { "select_next", "fallback" }
      opts.keymap["<C-p>"] = { "select_prev", "fallback" }

      -- If you do not want Enter to accept completions, remove this.
      opts.keymap["<CR>"] = { "accept", "fallback" }
    end,
  },
}
