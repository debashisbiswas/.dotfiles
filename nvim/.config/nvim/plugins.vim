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
    Plug 'itchyny/lightline.vim'
    Plug 'gruvbox-community/gruvbox'
    Plug 'shinchu/lightline-gruvbox.vim'
    Plug 'ayu-theme/ayu-vim'
    Plug 'yarisgutierrez/ayu-lightline'

    " Plugins
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'

    if has('nvim')
        Plug 'nvim-lua/plenary.nvim'
        Plug 'nvim-telescope/telescope.nvim'
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
        Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
        Plug 'neovim/nvim-lspconfig'
        Plug 'hrsh7th/cmp-nvim-lsp'
        Plug 'hrsh7th/cmp-buffer'
        Plug 'hrsh7th/nvim-cmp'
        Plug 'saadparwaiz1/cmp_luasnip'

        " Snippets
        Plug 'L3MON4D3/LuaSnip'
        Plug 'rafamadriz/friendly-snippets'
    endif

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
