" vim-plug installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

    " Declare the list of plugins.
    " Themes
    Plug 'gruvbox-community/gruvbox'
    Plug 'ayu-theme/ayu-vim'
    Plug 'itchyny/lightline.vim'
    Plug 'shinchu/lightline-gruvbox.vim'

    " Plugins
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'

    if has('nvim')
        Plug 'nvim-lua/plenary.nvim'
        Plug 'nvim-telescope/telescope.nvim'
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
        Plug 'neovim/nvim-lspconfig'
        Plug 'hrsh7th/cmp-nvim-lsp'
        Plug 'hrsh7th/cmp-buffer'
        Plug 'hrsh7th/nvim-cmp'

        " Snippers
        Plug 'L3MON4D3/LuaSnip'
        Plug 'rafamadriz/friendly-snippets'
    endif

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

set relativenumber
set wrap
set nojoinspaces
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4

filetype plugin indent on

syntax on

set lazyredraw
set nospell
set hlsearch
set incsearch
set ignorecase
set smartcase
set wildmenu

set vb t_vb=

set splitbelow
set splitright
set laststatus=2
set showcmd
set showmode

set backspace=indent,eol,start
set scrolljump=5
set scrolloff=10
set autoread
set autoindent
set smartindent
set nobackup

let mapleader=" "
set encoding=UTF-8
set cursorline

if has('nvim')
    set inccommand=split
endif

" Colors
set termguicolors
"let ayucolor="light"
let ayucolor="mirage"
set background=dark

colorscheme gruvbox
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'

map <Leader>h :wincmd h<CR>
map <Leader>j :wincmd j<CR>
map <Leader>k :wincmd k<CR>
map <Leader>l :wincmd l<CR>

" Find files using Telescope command-line sugar.
nnoremap <C-p> <cmd>Telescope git_files<cr>

" Set up language servers
if has('nvim')
    " Install before:
    " npm install -g typescript typescript-language-server
    lua require'lspconfig'.tsserver.setup{}
endif

set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({

        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),

      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })

  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })

  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['tsserver'].setup {
    capabilities = capabilities
  }
EOF

