-- Install packer
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  -- Quotes for spaces on Windows
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim "' .. install_path .. '"')
  vim.cmd([[packadd packer.nvim]])
end

require('packer').startup(function(use)
  use('wbthomason/packer.nvim')

  use('j-hui/fidget.nvim')

  use({
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    },
  })

  use({
    'jose-elias-alvarez/null-ls.nvim',
    requires = 'nvim-lua/plenary.nvim',
  })

  use({
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update({ with_sync = true }))
    end,
  })

  use({
    'nvim-treesitter/playground',
    requires = 'nvim-treesitter/nvim-treesitter',
  })

  use({
    'ThePrimeagen/harpoon',
    requires = 'nvim-lua/plenary.nvim',
  })

  -- Git related plugins
  use('tpope/vim-fugitive')
  use('tpope/vim-rhubarb')
  use('tpope/vim-surround')
  use('tpope/vim-repeat')
  use('lewis6991/gitsigns.nvim')

  use('ellisonleao/gruvbox.nvim')
  use('rose-pine/neovim')
  use('folke/tokyonight.nvim')
  use('nvim-lualine/lualine.nvim') -- Fancier statusline
  use('lukas-reineke/indent-blankline.nvim') -- Add indentation guides even on blank lines
  use('numToStr/Comment.nvim') -- "gc" to comment visual regions/lines
  use('tpope/vim-sleuth') -- Detect tabstop and shiftwidth automatically

  -- Fuzzy Finder (files, lsp, etc)
  use({ 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } })

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable('make') == 1 })

  use('windwp/nvim-ts-autotag')

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print([[
==================================
    Plugins are being installed
    Wait until Packer completes,
       then restart nvim
==================================]])
  return
end

-- Automatically source and re-compile packer
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand('$MYVIMRC'),
})

--
-- [[ SETS ]]
--
-- See `:help vim.o`

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set highlight on search
vim.o.hlsearch = false

vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

vim.o.scrolloff = 8
vim.o.showmode = false
vim.o.tabstop = 4

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

--
-- [[ REMAPS ]]
--
local keymap = vim.keymap.set
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
keymap('n', '<leader>h', '<C-w>h')
keymap('n', '<leader>j', '<C-w>j')
keymap('n', '<leader>k', '<C-w>k')
keymap('n', '<leader>l', '<C-w>l')
keymap('n', '<leader>t', vim.cmd.Ex)

keymap('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })
keymap('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })

keymap('n', '<C-d>', '<C-d>zz', { silent = true })
keymap('n', '<C-u>', '<C-u>zz', { silent = true })

keymap('n', 'n', 'nzzzv', { silent = true })
keymap('n', 'N', 'Nzzzv', { silent = true })

keymap('x', '<leader>p', [["_dP]])

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

--
-- [[ AUTOCOMMANDS ]]
--
-- See `:help vim.highlight.on_yank()`
local autocmd_group = vim.api.nvim_create_augroup('MaestosoCommands', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  group = autocmd_group,
  callback = function()
    vim.highlight.on_yank({ timeout = 40 })
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  group = autocmd_group,
  command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  group = autocmd_group,
  callback = function()
    vim.keymap.set('', 'q', ':q<CR>', { buffer = true })
  end,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
