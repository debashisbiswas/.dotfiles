vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', '<esc>', '<Cmd>nohlsearch<CR>', { silent = true })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<leader>bd', '<Cmd>bdelete<CR>', { desc = 'Delete buffer' })
vim.keymap.set('n', '<leader>bk', '<Cmd>bdelete<CR>', { desc = 'Kill buffer' })

vim.keymap.set('n', '<leader>vl', '<Cmd>Lazy<CR>', { desc = '[v]im: [l]azy' })

vim.keymap.set('n', '<leader>a,', '<Cmd>normal A,<CR>', { desc = 'line append comma' })
vim.keymap.set('n', '<leader>a;', '<Cmd>normal A;<CR>', { desc = 'line append semicolon' })
vim.keymap.set('x', '<leader>a,', ':normal A,<CR>', { desc = 'visual line append comma', silent = true })
vim.keymap.set('x', '<leader>a;', ':normal A;<CR>', { desc = 'visual line append semicolon', silent = true })

vim.keymap.set('n', '<leader>so', '<Cmd>source<CR>', { desc = 'Source current file', silent = true })
vim.keymap.set('n', '<leader>x', '<cmd>.lua<CR>', { desc = 'source line', silent = true })
vim.keymap.set('v', '<leader>x', ':lua<CR>', { desc = 'source selection', silent = true })

vim.keymap.set('n', '<leader>bs', '<Cmd>write<CR>', { desc = 'Write buffer', silent = true })
vim.keymap.set('n', '<leader>fs', '<Cmd>write<CR>', { desc = 'Write buffer', silent = true })
