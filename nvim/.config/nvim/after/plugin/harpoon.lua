require('harpoon').setup()

local mark = require 'harpoon.mark'
local ui = require 'harpoon.ui'

-- stylua: ignore
local nav = function(number)
  return function() ui.nav_file(number) end
end

vim.keymap.set('n', 'gh', function()
  mark.add_file()
  print 'Marked current file.'
end)

vim.keymap.set('n', '<leader>jj', ui.toggle_quick_menu)

vim.keymap.set('n', '<leader>jf', nav(1))
vim.keymap.set('n', '<leader>jd', nav(2))
vim.keymap.set('n', '<leader>js', nav(3))
vim.keymap.set('n', '<leader>ja', nav(4))
