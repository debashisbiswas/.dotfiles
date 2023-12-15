vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', 'k', "v:count == 0 && &filetype != 'harpoon' ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 && &filetype != 'harpoon' ? 'gj' : 'j'", { expr = true, silent = true })

-- vim.keymap.set('v', 'K', ":m '<--<CR>gv=gv", { desc = 'Move visual selection up' })
-- vim.keymap.set('v', 'J', ":m '>+<CR>gv=gv", { desc = 'Move visual selection down' })

vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, { desc = 'Show LSP signature help' })

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = 'Open diagnostics list' })
vim.keymap.set('n', '<leader>so', '<Cmd>source<CR>', { desc = 'Source current file' })

vim.keymap.set('n', '<leader>vc', function()
  local command = vim.fn.getreg '%' == '' and 'edit' or 'tabedit'
  local config_path = vim.fn.stdpath 'config'
  return '<Cmd>' .. command .. ' ' .. config_path .. '<CR>'
end, { desc = '[v]im: [c]onfig', expr = true })

vim.keymap.set('n', '<leader>vl', '<Cmd>Lazy<CR>', { desc = '[v]im: [l]azy' })
vim.keymap.set('n', '<leader>vm', '<Cmd>Mason<CR>', { desc = '[v]im: [m]ason' })
vim.keymap.set('n', '<leader>gs', '<Cmd>Git<CR>', { desc = 'fugitive status' })
vim.keymap.set({ 'n', 'x' }, 'gl', '<Plug>(EasyAlign)', { desc = 'EasyAlign' })

vim.keymap.set('n', '<leader>m', ':make ', { desc = 'make command' })
