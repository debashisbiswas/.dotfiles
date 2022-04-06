" vim-plug installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

    " Colors and Themes
    Plug 'itchyny/lightline.vim'
        Plug 'shinchu/lightline-gruvbox.vim'
        Plug 'yarisgutierrez/ayu-lightline'
    Plug 'gruvbox-community/gruvbox'
    Plug 'ayu-theme/ayu-vim'

    " Plugins
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install' }

    " Fuzzy finding
    " Telescope depends on plenary
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

    " LSP and completion
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'saadparwaiz1/cmp_luasnip'

    " Snippets
    Plug 'L3MON4D3/LuaSnip'
    Plug 'rafamadriz/friendly-snippets'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
