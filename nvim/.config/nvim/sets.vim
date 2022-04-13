syntax on
filetype plugin indent on

set tabstop=4 softtabstop=4 shiftwidth=4
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
set colorcolumn=80
set signcolumn=yes
set autochdir

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
set encoding=UTF-8
set cursorline
set inccommand=split

let mapleader=" "

augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 75})
augroup END

augroup trim_whitespace
  autocmd!
  autocmd BufWritePre * %s/\s\+$//e
augroup END
