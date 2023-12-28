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
    local curpos = vim.api.nvim_win_get_cursor(0)
    vim.cmd [[
      keeppatterns %s/\s\+$//e
      keeppatterns %s#\($\n\)\+\%$##e
    ]]
    vim.api.nvim_win_set_cursor(0, curpos)
  end,
})
