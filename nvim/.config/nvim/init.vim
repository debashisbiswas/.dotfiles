runtime ./plugins.vim
runtime ./maps.vim

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

