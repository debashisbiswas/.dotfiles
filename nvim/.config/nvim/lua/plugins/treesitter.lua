return {
  'nvim-treesitter/nvim-treesitter',
  version = false, -- from lazyvim
  build = ':TSUpdate',
  event = 'VeryLazy',

  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter-context',
      opts = {
        separator = '-',
      },
    },
    {
      'windwp/nvim-ts-autotag',
      opts = {
        aliases = {
          ['elixir'] = 'html',
        },
      },
    },
    'RRethy/nvim-treesitter-endwise',
  },

  opts = {
    ensure_installed = {
      'astro',
      'comment',
      'css',
      'javascript',
      'json',
      'lua',
      'markdown',
      'python',
      'toml',
      'tsx',
      'typescript',
    },

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    indent = { enable = true },
    highlight = { enable = true },
    endwise = { enable = true },
  },

  config = function(_, opts) require('nvim-treesitter.configs').setup(opts) end,
}
