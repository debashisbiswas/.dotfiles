local harpoon = require 'harpoon'

harpoon:setup()

vim.keymap.set('n', 'gh', function()
  print('Marked ' .. vim.fn.expand('%:t'))
  harpoon:list():append()
end)
vim.keymap.set('n', '<leader>jj', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set('n', '<leader>jf', function() harpoon:list():select(1) end)
vim.keymap.set('n', '<leader>jd', function() harpoon:list():select(2) end)
vim.keymap.set('n', '<leader>js', function() harpoon:list():select(3) end)
vim.keymap.set('n', '<leader>ja', function() harpoon:list():select(4) end)
