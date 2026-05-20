local source = {}

function source.new()
  return setmetatable({}, { __index = source })
end

local function cursor_range()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))

  return {
    start = {
      line = row - 1,
      character = col,
    },
    ["end"] = {
      line = row - 1,
      character = col,
    },
  }
end

function source:get_completions(_, callback)
  local range = cursor_range()

  callback({
    is_incomplete_backward = false,
    is_incomplete_forward = false,
    items = {
      {
        label = "morgan: console.log",
        kind = vim.lsp.protocol.CompletionItemKind.Snippet,
        insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet,
        textEdit = {
          range = range,
          newText = "console.log('[morgan-snip]', '${1:foo}')$0",
        },
        documentation = {
          kind = "markdown",
          value = "Adds `console.log` with `[morgan-snip] prefix for easy log filtering in the browser console.",
        },
      },
      {
        label = "morgan: JSX component",
        kind = vim.lsp.protocol.CompletionItemKind.Snippet,
        insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet,
        textEdit = {
          range = range,
          newText = "<div style={{backgroundColor: 'blue', width: 500, height: 500}}>${1:foo}$0</div>",
        },
        documentation = {
          kind = "markdown",
          value = "Adds a simple JSX div component with a blue background.",
        },
      },
    },
  })
end

return source
