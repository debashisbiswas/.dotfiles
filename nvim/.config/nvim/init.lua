require 'sets'
require 'autocommands'
require 'keymaps'

require('boilerplate').bootstrap_lazy()

local plugins = {
  'projekt0n/github-nvim-theme',
  { 'rose-pine/neovim', name = 'rose-pine' },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- Classical vim
  'tpope/vim-fugitive',
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'tpope/vim-vinegar',
  'junegunn/vim-easy-align',

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

  'lewis6991/gitsigns.nvim',
  'nvim-lualine/lualine.nvim',

  'ThePrimeagen/harpoon',

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

  'jose-elias-alvarez/null-ls.nvim',

  'folke/neodev.nvim',
  'b0o/schemastore.nvim',

  { 'j-hui/fidget.nvim', tag = 'legacy' },
  'SmiteshP/nvim-navic',
}

require('lazy').setup(plugins, {
  defaults = {
    lazy = false,
  },
})
