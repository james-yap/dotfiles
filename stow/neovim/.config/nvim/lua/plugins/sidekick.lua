return {
  {
    "folke/sidekick.nvim",
    opts = {
      nes = {
        enabled = false,
      },
      cli = {
        tools = {
          snappy = {
            cmd = { "pi", "--model", "openai-codex/gpt-5.6-luna", "--thinking", "off" },
          },
        },
      },
    },
  },
}
