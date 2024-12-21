return {
  {
    'tpope/vim-fugitive',
    keys = {
      { '<leader>gg', '<Cmd>Git<CR>', desc = 'git status' },
      { '<leader>gb', '<Cmd>Git blame<CR>', desc = 'git blame' },
    },
  },
  'tpope/vim-repeat',
  'tpope/vim-sleuth',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'tpope/vim-dispatch',

  {
    'junegunn/vim-easy-align',
    keys = {
      { 'gl', '<Plug>(EasyAlign)', desc = 'EasyAlign', mode = { 'n', 'x' } },
    },
  },
  {
    'airblade/vim-gitgutter',
    init = function()
      -- Changed for vim-gitgutter update time
      vim.o.updatetime = 250
    end,
  },
}
