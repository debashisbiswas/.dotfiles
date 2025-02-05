return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  init = function()
    vim.keymap.set('n', 'k', "v:count == 0 && &filetype != 'harpoon' ? 'gk' : 'k'", { expr = true, silent = true })
    vim.keymap.set('n', 'j', "v:count == 0 && &filetype != 'harpoon' ? 'gj' : 'j'", { expr = true, silent = true })
  end,
  keys = {
    {
      'gh',
      function()
        print('Marked ' .. vim.fn.expand '%:t')
        require('harpoon'):list():add()
      end,
      desc = 'Harpoon mark file',
    },
    {
      '<leader>jj',
      function()
        local harpoon = require 'harpoon'
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = 'Harpoon menu',
    },
    { '<leader>jf', function() require('harpoon'):list():select(1) end, desc = 'Harpoon file 1' },
    { '<leader>jd', function() require('harpoon'):list():select(2) end, desc = 'Harpoon file 2' },
    { '<leader>js', function() require('harpoon'):list():select(3) end, desc = 'Harpoon file 3' },
    { '<leader>ja', function() require('harpoon'):list():select(4) end, desc = 'Harpoon file 4' },
  },
}
