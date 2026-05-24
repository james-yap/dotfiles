local M = {}

function M.open_tab_job(cmd, opts)
  opts = opts or {}

  vim.cmd("tabnew")
  vim.fn.jobstart(cmd, { cwd = opts.cwd, term = true })

  if opts.start_insert then
    vim.cmd("startinsert")
  end
end

return M
