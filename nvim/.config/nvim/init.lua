local path_package = vim.fn.stdpath 'data' .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd 'echo "Installing `mini.nvim`" | redraw'
  local clone_cmd = {
    'git',
    'clone',
    '--filter=blob:none',
    -- Uncomment next line to use 'stable' branch
    '--branch',
    'stable',
    'https://github.com/nvim-mini/mini.nvim',
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd 'packadd mini.nvim | helptags ALL'
  vim.cmd 'echo "Installed `mini.nvim`" | redraw'
end

------------------------------------------------------------
-- Sets
------------------------------------------------------------

vim.g.mapleader = ' '
vim.g.maplocalleader = ' m'

vim.o.termguicolors = true

vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.undofile = true

vim.o.scrolloff = 5
vim.o.cursorline = false

vim.o.breakindent = true

vim.opt.completeopt = { 'menuone', 'noselect' }

vim.wo.signcolumn = 'yes'

vim.o.ignorecase = true
vim.o.smartcase = true

vim.diagnostic.config {
  float = { source = true },
  jump = { float = true },
}

vim.o.winborder = 'rounded'

vim.keymap.set('n', '<leader>so', vim.cmd.source)
vim.keymap.set('n', '<leader>fs', vim.cmd.update)
vim.keymap.set('n', '<esc>', vim.cmd.nohlsearch)
vim.keymap.set('n', '<leader>bd', '<Cmd>bdelete<CR>', { desc = 'Delete buffer' })
vim.keymap.set('n', '<leader>bk', '<Cmd>bdelete<CR>', { desc = 'Kill buffer' })

vim.keymap.set('n', '<leader>cp', function()
  local path = vim.fn.expand '%'
  vim.fn.setreg('+', path)
  vim.notify('Copied path to clipboard: ' .. path)
end, { desc = 'Copy path' })

local config_group = vim.api.nvim_create_augroup('ConfigGroup', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = config_group,
  pattern = '*',
  callback = function() vim.highlight.on_yank { timeout = 100 } end,
})

vim.filetype.add {
  extension = {
    fnc = 'plsql',
    vw = 'plsql',
  },
}

require('mini.deps').setup()

------------------------------------------------------------
-- Completion
------------------------------------------------------------

require('mini.completion').setup {}

------------------------------------------------------------
-- LSP
------------------------------------------------------------

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

MiniDeps.add {
  source = 'neovim/nvim-lspconfig',
  depends = { 'b0o/schemastore.nvim' },
}

MiniDeps.add 'folke/lazydev.nvim'
require('lazydev').setup {
  library = {
    -- See the configuration section for more details
    -- Load luvit types when the `vim.uv` word is found
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}

-- On attach

vim.api.nvim_create_autocmd('LspAttach', {
  group = config_group,
  callback = function(args)
    -- :help gO, :help lsp-defaults
    vim.keymap.set('n', 'gO', require('telescope.builtin').lsp_document_symbols)
    vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions)
  end,
})

-- Enable servers

vim.lsp.enable 'astro'
vim.lsp.enable 'basedpyright'
vim.lsp.enable 'cssls'
vim.lsp.enable 'eslint'
vim.lsp.enable 'gleam'
vim.lsp.enable 'gopls'
vim.lsp.enable 'harper_ls'
vim.lsp.enable 'nixd'
vim.lsp.enable 'rust_analyzer'
vim.lsp.enable 'svelte'
vim.lsp.enable 'vtsls'

vim.lsp.config('html', {
  settings = {
    html = {
      format = {
        indentInnerHtml = true,
      },
    },
  },
})
vim.lsp.enable 'html'

vim.lsp.config('tailwindcss', {
  settings = {
    tailwindCSS = {
      includeLanguages = {
        elixir = 'html-eex',
        eelixir = 'html-eex',
        heex = 'html-eex',
      },
    },
  },
})
vim.lsp.enable 'tailwindcss'

vim.lsp.config('emmet_language_server', {
  filetypes = { 'css', 'html', 'javascriptreact', 'typescriptreact', 'heex' },
})
vim.lsp.enable 'emmet_language_server'

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})
vim.lsp.enable 'lua_ls'

vim.lsp.config('elixirls', {
  cmd = { 'elixir-ls' },
})
vim.lsp.enable 'elixirls'

vim.lsp.config('jsonls', {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
})
vim.lsp.enable 'jsonls'

vim.lsp.config('yamlls', {
  settings = {
    yaml = {
      schemaStore = {
        -- You must disable built-in schemaStore support if you want to use
        -- this plugin and its advanced options like `ignore`.
        enable = false,
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
})
vim.lsp.enable 'yamlls'

------------------------------------------------------------
-- Snippets
------------------------------------------------------------

local gen_loader = require('mini.snippets').gen_loader
require('mini.snippets').setup {
  snippets = {
    gen_loader.from_lang(),
  },
}

--------------------------------------------------------------
-- Treesitter
------------------------------------------------------------

MiniDeps.add {
  source = 'nvim-treesitter/nvim-treesitter',
  checkout = 'master',
  monitor = 'main',
  hooks = { post_checkout = vim.cmd.TSUpdate },
  depends = {
    'nvim-treesitter/nvim-treesitter-context',
    'windwp/nvim-ts-autotag',
    'RRethy/nvim-treesitter-endwise', -- Enables itself! No config needed.
  },
}

require('treesitter-context').setup {
  separator = '-',
  max_lines = 1,
}

require('nvim-ts-autotag').setup {
  aliases = {
    ['elixir'] = 'html',
  },
}

require('nvim-treesitter.configs').setup {
  auto_install = true,
  indent = { enable = true },
  highlight = { enable = true },
}

------------------------------------------------------------
-- Oil
------------------------------------------------------------

MiniDeps.add 'stevearc/oil.nvim'
require('oil').setup { view_options = { show_hidden = true } }
vim.keymap.set('n', '-', '<cmd>Oil<cr>')

------------------------------------------------------------
-- Picker
------------------------------------------------------------

MiniDeps.add {
  source = 'nvim-telescope/telescope.nvim',
  depends = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    {
      source = 'isak102/telescope-git-file-history.nvim',
      depends = {
        'tpope/vim-fugitive',
      },
    },
  },
}

require('telescope').setup {
  defaults = {
    layout_config = { prompt_position = 'top' },
    sorting_strategy = 'ascending',
    file_ignore_patterns = { 'node_modules', '.git' },
  },

  pickers = {
    find_files = {
      -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d
      find_command = { 'rg', '--files', '--hidden', '--glob', '!.git' },
    },
    live_grep = {
      additional_args = { '--hidden' },
    },
  },

  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_cursor {},
    },
  },
}

require('telescope').load_extension 'git_file_history'
require('telescope').load_extension 'ui-select'

vim.api.nvim_set_hl(0, 'TelescopeMatching', { link = 'Statement' })
vim.api.nvim_set_hl(0, 'TelescopeTitle', { link = 'Statement' })
vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { link = 'Statement' })

vim.keymap.set('n', '<leader>ss', '<cmd>Telescope builtin<cr>')
vim.keymap.set('n', '<leader>sf', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>sh', '<cmd>Telescope help_tags<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader>sw', '<cmd>Telescope grep_string<cr>')
vim.keymap.set('n', '<leader>sg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>sd', '<cmd>Telescope diagnostics<cr>')
vim.keymap.set('n', '<leader>sr', '<cmd>Telescope resume<cr>')

vim.keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>')
vim.keymap.set('n', '<leader>ht', '<cmd>Telescope colorscheme enable_preview=true<cr>')
vim.keymap.set('n', '<leader>bb', '<cmd>Telescope buffers<cr>')

vim.keymap.set(
  'n',
  '<leader>/',
  function()
    require('telescope.builtin').current_buffer_fuzzy_find(
      require('telescope.themes').get_dropdown { winblend = 10, previewer = true }
    )
  end
)

vim.keymap.set(
  'n',
  '<leader>;',
  function()
    require('telescope.builtin').commands(require('telescope.themes').get_ivy {
      winblend = 10,
    })
  end
)

vim.keymap.set(
  'n',
  '<leader>vc',
  function()
    require('telescope.builtin').find_files(require('telescope.themes').get_dropdown { cwd = vim.fn.stdpath 'config' })
  end
)

vim.keymap.set(
  'n',
  '<leader>vs',
  function() require('telescope.builtin').live_grep { cwd = vim.fn.stdpath 'config' } end
)

vim.keymap.set('n', '<leader>gh', function() require('telescope').extensions.git_file_history.git_file_history() end)

------------------------------------------------------------
-- UI
------------------------------------------------------------

MiniDeps.add 'miikanissi/modus-themes.nvim'
require('modus-themes').setup {
  transparent = false,
  line_nr_column_background = false,
  sign_column_background = true,
  styles = {
    comments = { italic = false },
    keywords = { italic = false },
  },
}
vim.cmd.colorscheme 'modus'

MiniDeps.add 'brenoprata10/nvim-highlight-colors'
require('nvim-highlight-colors').setup {
  render = 'background',
  enable_tailwind = true,
}

require('mini.statusline').setup {
  use_icons = false,
}

vim.o.showmode = false

require('mini.notify').setup()

------------------------------------------------------------
-- The classics
------------------------------------------------------------

MiniDeps.add 'tpope/vim-repeat'
MiniDeps.add 'tpope/vim-sleuth'
MiniDeps.add 'tpope/vim-surround'
MiniDeps.add 'tpope/vim-unimpaired'
MiniDeps.add 'tpope/vim-dispatch'
MiniDeps.add 'tpope/vim-abolish'

------------------------------------------------------------
-- Git
------------------------------------------------------------

MiniDeps.add 'tpope/vim-fugitive'
MiniDeps.add 'airblade/vim-gitgutter'

vim.o.updatetime = 250 -- vim-gitgitter update time

vim.keymap.set('n', '<leader>gg', '<cmd>Git<cr>')
vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<cr>')

------------------------------------------------------------
-- Editing
------------------------------------------------------------

MiniDeps.add 'windwp/nvim-autopairs'
require('nvim-autopairs').setup {}

require('mini.align').setup {}

------------------------------------------------------------
-- Supermaven
------------------------------------------------------------

if not (os.getenv 'IS_WORK_MACHINE' == 'true') then
  MiniDeps.add 'supermaven-inc/supermaven-nvim'

  require('supermaven-nvim').setup {
    keymaps = {
      accept_suggestion = '<M-l>',
      accept_word = '<M-j>',
    },
    ignore_filetypes = { 'markdown' },
  }
end

------------------------------------------------------------
-- Linting
------------------------------------------------------------

MiniDeps.add 'mfussenegger/nvim-lint'

local lint = require 'lint'
lint.linters_by_ft = {
  python = { 'ruff' },
}

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'TextChanged' }, {
  group = config_group,
  callback = function() lint.try_lint() end,
})

------------------------------------------------------------
-- Formatting
------------------------------------------------------------

MiniDeps.add 'stevearc/conform.nvim'

local js_formatters = { 'prettierd' }

require('conform').setup {
  default_format_opts = {
    lsp_format = 'fallback',
    async = true,
  },
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
    return {}
  end,

  formatters_by_ft = {
    python = { 'ruff_fix', 'ruff_format' },

    lua = { 'stylua' },
    rust = { 'rustfmt' },

    html = js_formatters,
    css = js_formatters,
    json = js_formatters,

    typescript = js_formatters,
    javascript = js_formatters,
    typescriptreact = js_formatters,
    javascriptreact = js_formatters,

    astro = js_formatters,
    svelte = js_formatters,

    nix = { 'nixfmt' },
  },
}

vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformat-on-save',
  bang = true,
})

vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = 'Re-enable autoformat-on-save',
})
