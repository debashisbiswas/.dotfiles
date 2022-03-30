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
    " Plug 'preservim/nerdtree'
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

" map <Leader>t :NERDTreeToggle<CR>
map <Leader>h :wincmd h<CR>
map <Leader>j :wincmd j<CR>
map <Leader>k :wincmd k<CR>
map <Leader>l :wincmd l<CR>

" Find files using Telescope command-line sugar.
nnoremap <C-p> <cmd>Telescope git_files<cr>

" Set up language servers
if has('nvim')
    lua require'lspconfig'.tsserver.setup{}
endif
