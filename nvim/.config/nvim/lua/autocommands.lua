local config_group = vim.api.nvim_create_augroup('ConfigGroup', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = config_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank {
      timeout = 100,
    }
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = config_group,
  pattern = '*',
  -- save/restore search term, remove trailing whitespace, remove trailing empty lines
  -- TODO: this should save your place with a mark or something
  callback = function()
    -- Trim trailing whitespace
    local curpos = vim.api.nvim_win_get_cursor(0)
    vim.cmd [[keeppatterns %s/\s\+$//e]]
    vim.api.nvim_win_set_cursor(0, curpos)

    -- Trim blank lines at end of buffer
    local n_lines = vim.api.nvim_buf_line_count(0)
    local last_nonblank = vim.fn.prevnonblank(n_lines)
    if last_nonblank < n_lines then vim.api.nvim_buf_set_lines(0, last_nonblank, n_lines, true, {}) end
  end,
})
