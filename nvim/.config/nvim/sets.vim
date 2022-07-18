syntax on
filetype plugin indent on

set tabstop=4 softtabstop=4 shiftwidth=4
set expandtab
set smarttab
set smartindent

set guicursor=

set number
set relativenumber

set nohlsearch
set noerrorbells
set hidden
set nowrap
set noswapfile
set nobackup
set incsearch
set ignorecase
set smartcase
set termguicolors
set scrolloff=8
set noshowmode
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
set encoding=UTF-8
set cursorline
set inccommand=split
set mouse=a

let mapleader=" "

augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

augroup trim_whitespace
  autocmd!
  autocmd BufWritePre * %s/\s\+$//e
augroup END

augroup quit_help
  autocmd!
  autocmd FileType help noremap <buffer> q :q<cr>
augroup END

set guifont=JetBrainsMono\ NF:h13
let g:neovide_cursor_animation_length = 0
