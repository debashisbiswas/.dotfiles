return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    preset = 'modern',
    icons = { mappings = false },
    spec = {
      { '<leader>', group = 'leader' },
      { '<leader>a', group = 'append' },
      { '<leader>b', group = 'buffer' },
      { '<leader>c', group = 'code' },
      { '<leader>g', group = 'git' },
      { '<leader>h', group = 'hunk' }, -- this should be the help page!
      { '<leader>j', group = 'jump' },
      { '<leader>m', group = 'localleader' },
      { '<leader>s', group = 'search' },
      { '<leader>v', group = 'vim' },
      { '<leader>w', proxy = '<c-w>', group = 'windows' }, -- proxy to window mappings
    },
  },
}
