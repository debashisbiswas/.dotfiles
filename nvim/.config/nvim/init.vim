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

set completeopt=menu,menuone,noselect

lua <<EOF
    -- Setup nvim-cmp.
    local cmp = require'cmp'

    cmp.setup({
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
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
            -- { name = 'vsnip' }, -- For vsnip users.
            { name = 'luasnip' }, -- For luasnip users.
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
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- npm i -g typescript typescript-language-server
    require('lspconfig')['tsserver'].setup {
        capabilities = capabilities
    }

    -- npm i -g vscode-langservers-extracted
    require('lspconfig')['eslint'].setup {
        capabilities = capabilities
    }

    -- npm i -g vscode-langservers-extracted
    require('lspconfig')['html'].setup {
        capabilities = capabilities
    }

    -- npm i -g vscode-langservers-extracted
    require('lspconfig')['cssls'].setup {
        capabilities = capabilities
    }

    -- npm i -g vscode-langservers-extracted
    require('lspconfig')['jsonls'].setup {
        capabilities = capabilities,
    }

    -- Treesitter setup
    require'nvim-treesitter.configs'.setup {
        -- One of "all", "maintained" (parsers with maintainers), or a list of languages
        ensure_installed = {
            "javascript",
            "typescript",
            "html",
            "css",
            "bash",
            "c",
            "json",
            "yaml",
            "rust",
            "python"
        },

        -- Install languages synchronously (only applied to `ensure_installed`)
        sync_install = false,

        highlight = {
            enable = true,
            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true,
        }
    }
EOF
