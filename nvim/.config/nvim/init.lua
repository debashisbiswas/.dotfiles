require 'sets'
require 'autocommands'
require 'keymaps'

require('boilerplate').bootstrap_lazy()

require('lazy').setup({
  -- Color
  'EdenEast/nightfox.nvim',

  -- Classical vim
  'tpope/vim-fugitive',
  'tpope/vim-repeat',
  'tpope/vim-sleuth',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'tpope/vim-dispatch',

  'junegunn/vim-easy-align',
  'airblade/vim-gitgutter',

  'tpope/vim-dadbod',
  'kristijanhusak/vim-dadbod-ui',
  'kristijanhusak/vim-dadbod-completion',

  -- Neovim
  'nvim-lua/plenary.nvim',

  { 'nvim-telescope/telescope.nvim',   branch = '0.1.x' },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function() return vim.fn.executable 'make' == 1 end,
  },

  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  'nvim-treesitter/nvim-treesitter-context',

  'numToStr/Comment.nvim',
  { 'ThePrimeagen/harpoon', branch = 'harpoon2' },
  'nvim-lualine/lualine.nvim',
  'folke/which-key.nvim',

  'stevearc/oil.nvim',
  -- When disabling netrw with oil.nvim, gx breaks as it's part of netrw. As of
  -- nvim 0.10, gx won't be tied to netrw, but until then, this plugin restores
  -- the functionality
  'josa42/nvim-gx',

  'folke/zen-mode.nvim',

  -- Snippets
  'L3MON4D3/LuaSnip',
  'rafamadriz/friendly-snippets',

  -- Completion
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'saadparwaiz1/cmp_luasnip',

  -- Auto
  'windwp/nvim-autopairs',
  'windwp/nvim-ts-autotag',
  'RRethy/nvim-treesitter-endwise',

  -- LSP
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',

  'stevearc/conform.nvim',
  'mfussenegger/nvim-lint',

  -- TODO: for nvim 0.10+, https://github.com/folke/lazydev.nvim
  'folke/neodev.nvim',
  'b0o/schemastore.nvim',

  'j-hui/fidget.nvim',

  -- Colors
  'brenoprata10/nvim-highlight-colors',
  'roobert/tailwindcss-colorizer-cmp.nvim',

  {
    "David-Kunz/gen.nvim",
    opts = {
      model = "mistral",   -- The default model to use.
      host = "localhost",  -- The host running the Ollama service.
      port = "11434",      -- The port on which the Ollama service is listening.
      quit_map = "q",      -- set keymap for close the response window
      retry_map = "<c-r>", -- set keymap to re-send the current prompt
      init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,

      -- Function to initialize Ollama
      command = function(options)
        local body = { model = options.model, stream = true }
        return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
      end,
      -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
      -- This can also be a command string.
      -- The executed command must return a JSON object with { response, context }
      -- (context property is optional).
      -- list_models = '<omitted lua function>', -- Retrieves a list of model names
      display_mode = "float", -- The display mode. Can be "float" or "split" or "horizontal-split".
      show_prompt = true,     -- Shows the prompt submitted to Ollama.
      show_model = true,      -- Displays which model you are using at the beginning of your chat session.
      no_auto_close = false,  -- Never closes the window automatically.
      debug = false           -- Prints errors and the command which is run.
    }
  },
}, {
  defaults = {
    lazy = false,
  },
})
