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

    " Plugins
    Plug 'preservim/nerdtree'
    Plug 'tpope/vim-fugitive'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

let mapleader=";"
set encoding=UTF-8
syntax on
filetype on
set title
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
set nobackup
set scrolloff=10

if has('nvim')
    set inccommand=split
endif

" Colors
set termguicolors     " enable true colors support
"let ayucolor="light" " for mirage version of theme
"let ayucolor="mirage" " for mirage version of theme
let ayucolor="mirage"
colorscheme ayu
set background=dark

map <Leader>t :NERDTreeToggle<CR>
map <Leader>h :wincmd h<CR>
map <Leader>j :wincmd j<CR>
map <Leader>k :wincmd k<CR>
map <Leader>l :wincmd l<CR>

