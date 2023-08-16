--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-fugitive',
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'tpope/vim-vinegar',
  'tpope/vim-unimpaired',

  {
    'junegunn/vim-easy-align',
    config = function()
      vim.keymap.set({ 'n', 'x' }, 'gl', '<Plug>(EasyAlign)', { desc = 'EasyAlign' })
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_c = {
          { 'filename' },
          {
            function()
              return require('nvim-navic').get_location()
            end,
            cond = function()
              return package.loaded['nvim-navic'] and require('nvim-navic').is_available()
            end,
          },
        },
      },
    },
  },

  { 'numToStr/Comment.nvim', opts = {} },

  { import = 'plugins' },
}, {
  defaults = {
    lazy = false,
  },
})

vim.o.hlsearch = false
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.mouse = 'a'

vim.o.breakindent = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.scrolloff = 5
vim.o.cursorline = true

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.wo.signcolumn = 'yes'

vim.o.completeopt = 'menuone,noselect'

vim.o.termguicolors = true

-- this fixes some treesitter errors on windows
if vim.fn.exists 'shellslash' ~= 0 then
  vim.o.shellslash = true
end

if vim.fn.has 'win32' == 1 then
  -- :h shell-powershell
  vim.cmd [[
    let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
    let &shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';'
    let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
    let &shellpipe  = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
    set shellquote= shellxquote=
  ]]
end

vim.diagnostic.config { float = { source = 'always' } }

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', 'k', "v:count == 0 && &filetype != 'harpoon' ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 && &filetype != 'harpoon' ? 'gj' : 'j'", { expr = true, silent = true })

-- vim.keymap.set('v', 'K', ":m '<--<CR>gv=gv", { desc = 'Move visual selection up' })
-- vim.keymap.set('v', 'J', ":m '>+<CR>gv=gv", { desc = 'Move visual selection down' })

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<leader>vc', '<Cmd>edit $MYVIMRC<CR>', { desc = '[v]im: [c]onfig' })
vim.keymap.set('n', '<leader>vl', '<Cmd>Lazy<CR>', { desc = '[v]im: [l]azy' })
vim.keymap.set('n', '<leader>vm', '<Cmd>Mason<CR>', { desc = '[v]im: [m]ason' })
vim.keymap.set('n', '<leader>so', '<Cmd>source<CR>', { desc = 'Source current file' })

vim.keymap.set('n', '<leader>gs', '<Cmd>Git<CR>', { desc = 'fugitive status' })

local config_group = vim.api.nvim_create_augroup('ConfigGroup', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = config_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank {
      timeout = 100,
    }
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = config_group,
  pattern = '*',
  -- save/restore search term, remove trailing whitespace, remove trailing empty lines
  -- TODO: this should save your place with a mark or something
  command = [[
    let _s=@/
    %s/\s\+$//e
    %s#\($\n\)\+\%$##e
    let @/=_s
  ]],
})

-- vim: ts=2 sts=2 sw=2 et
