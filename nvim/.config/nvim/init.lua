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

  {
    'junegunn/vim-easy-align',
    config = function()
      vim.keymap.set({ 'n', 'x' }, 'gl', '<Plug>(EasyAlign)', { desc = 'EasyAlign' })
    end,
  },

  { 'folke/which-key.nvim', config = true },
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
}, {})

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

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- this fixes some treesitter errors on windows
vim.o.shellslash = true

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- TODO: this should not apply for harpoon buffers
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = highlight_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank {
      timeout = 100,
    }
  end,
})

local ConfigGroup = vim.api.nvim_create_augroup('ConfigGroup', {})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = ConfigGroup,
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

vim.diagnostic.config { float = { source = 'always' } }
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('v', 'K', "<Cmd>m '<--<CR>gv=gv", { desc = 'Move visual selection up', silent = true })
vim.keymap.set('v', 'J', "<Cmd>m '>+<CR>gv=gv", { desc = 'Move visual selection down', silent = true })

vim.keymap.set('n', '[e', '<Cmd>m --<CR>==', { desc = 'Move current line up', silent = true })
vim.keymap.set('n', ']e', '<Cmd>m +<CR>==', { desc = 'Move current line down', silent = true })

vim.keymap.set('n', '[q', '<Cmd>cprevious<CR>', { desc = 'Next quickfix list entry', silent = true })
vim.keymap.set('n', ']q', '<Cmd>cnext<CR>', { desc = 'Previous quickfix list entry', silent = true })

-- TODO: should this follow the buffer's line endings rather than only inserting newline?
vim.keymap.set('n', '[<Space>', [[<Cmd>put!=repeat(nr2char(10), v:count1)<CR>+]], { desc = 'Next quickfix list entry', silent = true })
vim.keymap.set('n', ']<Space>', [[<Cmd>put =repeat(nr2char(10), v:count1)<CR>-]], { desc = 'Previous quickfix list entry', silent = true })

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('n', '<leader>vc', '<Cmd>edit $MYVIMRC<CR>', { desc = 'Edit config', silent = true })
vim.keymap.set('n', '<leader>so', '<Cmd>source<CR>', { desc = 'Source current file' })

vim.keymap.set('n', '<leader>gs', '<Cmd>Git<CR>', { desc = 'fugitive status' })

-- vim: ts=2 sts=2 sw=2 et
