require 'sets'
require 'autocommands'
require 'keymaps'

require('boilerplate').bootstrap_lazy()

require('lazy').setup({
  -- Color
  'EdenEast/nightfox.nvim',

  -- Classical vim
  'tpope/vim-fugitive',
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'junegunn/vim-easy-align',
  'airblade/vim-gitgutter',

  -- Neovim
  'nvim-lua/plenary.nvim',

  { 'nvim-telescope/telescope.nvim', branch = '0.1.x' },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

  'numToStr/Comment.nvim',
  'ThePrimeagen/harpoon',
  'stevearc/oil.nvim',

  -- Snippets
  'L3MON4D3/LuaSnip',
  'rafamadriz/friendly-snippets',

  -- Completion
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-nvim-lsp',
  'saadparwaiz1/cmp_luasnip',

  -- LSP
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',

  'stevearc/conform.nvim',
  'mfussenegger/nvim-lint',

  'folke/neodev.nvim',
  'b0o/schemastore.nvim',

  { 'j-hui/fidget.nvim', tag = 'legacy' },
}, {
  defaults = {
    lazy = false,
  },
})
