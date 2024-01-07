require('oil').setup()

vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
vim.keymap.set('n', 'gx', require('gx').gx)
