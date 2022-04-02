syntax on
filetype plugin indent on

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent

" always keep cursor as block
set guicursor=

" line numbers
set number
set relativenumber

set nohlsearch
set noerrorbells
set hidden
set nowrap
set noswapfile
set nobackup
set incsearch
set termguicolors
set scrolloff=8
set noshowmode
set completeopt=menuone,noinsert,noselect
set colorcolumn=80
set signcolumn=yes

set nojoinspaces
set wildmode=longest,list,full
set wildmenu
set wildignore+=**/dist/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*
set wildignore+=*.pyc

set vb t_vb=
set backspace=indent,eol,start
set autoread
let mapleader=" "
set encoding=UTF-8
set cursorline
if has('nvim')
    set inccommand=split
endif
