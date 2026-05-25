local M = {}

local function start_job(cmd, opts)
  vim.fn.jobstart(cmd, { cwd = opts.cwd, term = true })

  if opts.start_insert then
    vim.cmd("startinsert")
  end
end

function M.open_buffer_job(cmd, opts)
  opts = opts or {}

  vim.cmd("enew")
  start_job(cmd, opts)
end

function M.open_tab_job(cmd, opts)
  opts = opts or {}

  vim.cmd("tabnew")
  start_job(cmd, opts)
end

return M
