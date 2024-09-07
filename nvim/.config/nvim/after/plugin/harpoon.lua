local harpoon = require 'harpoon'

harpoon:setup()

vim.keymap.set('n', 'gh', function()
  print('Marked ' .. vim.fn.expand('%:t'))
  harpoon:list():add()
end)

vim.keymap.set('n', '<leader>jj', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "harpoon menu" })

vim.keymap.set('n', '<leader>jf', function() harpoon:list():select(1) end, { desc = "harpoon file 1" })
vim.keymap.set('n', '<leader>jd', function() harpoon:list():select(2) end, { desc = "harpoon file 2" })
vim.keymap.set('n', '<leader>js', function() harpoon:list():select(3) end, { desc = "harpoon file 3" })
vim.keymap.set('n', '<leader>ja', function() harpoon:list():select(4) end, { desc = "harpoon file 4" })
