vim.keymap.set('n', '<localleader>x', require('kulala').run, { desc = 'Execute request', buffer = true })
vim.keymap.set('n', '<localleader>t', require('kulala').toggle_view, { desc = 'Toggle view', buffer = true })
vim.keymap.set('n', '<localleader>i', require('kulala').inspect, { desc = 'Inspect', buffer = true })
