return {
  {
    'ThePrimeagen/harpoon',
    config = function()
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
      vim.keymap.set('n', 'gH', ui.toggle_quick_menu)

      vim.keymap.set('n', '<leader>f', nav(1))
      vim.keymap.set('n', '<leader>d', nav(2))
      vim.keymap.set('n', '<leader>s', nav(3))
      vim.keymap.set('n', '<leader>a', nav(4))
    end,
  },

  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    config = function()
      vim.keymap.set('v', '<leader>rr', require('refactoring').select_refactor)
    end,
  },
}
