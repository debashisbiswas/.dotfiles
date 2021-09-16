" vim-plug installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

    " Declare the list of plugins.
    Plug 'morhetz/gruvbox'
    Plug 'ayu-theme/ayu-vim'
    Plug 'preservim/nerdtree'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

set encoding=UTF-8
syntax on
filetype on
set autoread
set relativenumber
set cursorline
set shiftwidth=4
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set expandtab
set hlsearch incsearch
set ignorecase

" Colors
set termguicolors     " enable true colors support
"let ayucolor="light" " for mirage version of theme
"let ayucolor="mirage" " for mirage version of theme
let ayucolor="mirage"   " for dark version of theme
colorscheme ayu

map <Leader>t :NERDTreeToggle<CR>

