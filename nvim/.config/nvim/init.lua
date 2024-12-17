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
  'tpope/vim-sleuth',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'tpope/vim-dispatch',

  'junegunn/vim-easy-align',
  'airblade/vim-gitgutter',

  'tpope/vim-dadbod',
  'kristijanhusak/vim-dadbod-ui',
  'kristijanhusak/vim-dadbod-completion',

  -- Neovim
  'nvim-lua/plenary.nvim',

  { 'nvim-telescope/telescope.nvim',   branch = '0.1.x' },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function() return vim.fn.executable 'make' == 1 end,
  },

  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  'nvim-treesitter/nvim-treesitter-context',

  'numToStr/Comment.nvim',
  { 'ThePrimeagen/harpoon', branch = 'harpoon2' },
  'nvim-lualine/lualine.nvim',
  'folke/which-key.nvim',

  'stevearc/oil.nvim',
  -- When disabling netrw with oil.nvim, gx breaks as it's part of netrw. As of
  -- nvim 0.10, gx won't be tied to netrw, but until then, this plugin restores
  -- the functionality
  'josa42/nvim-gx',

  'folke/zen-mode.nvim',

  -- Snippets
  'L3MON4D3/LuaSnip',
  'rafamadriz/friendly-snippets',

  -- Auto
  'windwp/nvim-autopairs',
  'windwp/nvim-ts-autotag',
  'RRethy/nvim-treesitter-endwise',

  -- LSP
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',

  'stevearc/conform.nvim',
  'mfussenegger/nvim-lint',

  -- TODO: for nvim 0.10+, https://github.com/folke/lazydev.nvim
  'folke/neodev.nvim',
  'b0o/schemastore.nvim',

  'j-hui/fidget.nvim',

  -- Colors
  'brenoprata10/nvim-highlight-colors',

  { import = "plugins" }
}, {
  defaults = {
    lazy = false,
  },
  change_detection = { notify = false }
})
