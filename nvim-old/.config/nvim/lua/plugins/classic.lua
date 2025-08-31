return {
  {
    'tpope/vim-fugitive',
    keys = {
      { '<leader>gg', '<Cmd>vertical Git<CR>', desc = 'git status' },
      { '<leader>gb', '<Cmd>Git blame<CR>', desc = 'git blame' },
    },
  },
  'tpope/vim-repeat',
  'tpope/vim-sleuth',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'tpope/vim-dispatch',
  'tpope/vim-abolish',

  {
    'junegunn/vim-easy-align',
    keys = {
      { 'gl', '<Plug>(EasyAlign)', desc = 'EasyAlign', mode = { 'n', 'x' } },
    },
  },
  {
    'airblade/vim-gitgutter',
    init = function() vim.o.updatetime = 250 end,
  },
}
