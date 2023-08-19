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
  command = [[
    let _s=@/
    %s/\s\+$//e
    %s#\($\n\)\+\%$##e
    let @/=_s
  ]],
})
