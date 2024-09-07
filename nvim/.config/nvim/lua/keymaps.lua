vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', 'k', "v:count == 0 && &filetype != 'harpoon' ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 && &filetype != 'harpoon' ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, { desc = 'Show LSP signature help' })

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = 'Open diagnostics list' })
vim.keymap.set('n', '<leader>so', '<Cmd>source<CR>', { desc = 'Source current file' })

vim.keymap.set('n', '<leader>bd', '<Cmd>bdelete<CR>', { desc = 'Delete buffer' })
vim.keymap.set('n', '<leader>bk', '<Cmd>bdelete<CR>', { desc = 'Kill buffer' })

vim.keymap.set(
  'n',
  '<leader>vc',
  function() require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' } end,
  { desc = '[v]im [c]onfig' }
)

vim.keymap.set('n', '<leader>vl', '<Cmd>Lazy<CR>', { desc = '[v]im: [l]azy' })
vim.keymap.set('n', '<leader>vm', '<Cmd>Mason<CR>', { desc = '[v]im: [m]ason' })
vim.keymap.set('n', '<leader>gs', '<Cmd>Git<CR>', { desc = 'fugitive status' })
vim.keymap.set({ 'n', 'x' }, 'gl', '<Plug>(EasyAlign)', { desc = 'EasyAlign' })

vim.keymap.set('n', '<leader>a,', '<Cmd>normal A,<CR>', { desc = 'line append comma' })
vim.keymap.set('n', '<leader>a;', '<Cmd>normal A;<CR>', { desc = 'line append semicolon' })
vim.keymap.set('x', '<leader>a,', ':normal A,<CR>', { desc = 'visual line append comma', silent = true })
vim.keymap.set('x', '<leader>a;', ':normal A;<CR>', { desc = 'visual line append semicolon', silent = true })
