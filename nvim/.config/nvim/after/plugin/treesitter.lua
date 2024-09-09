-- avoiding treesitter-angular as it breaks TS files
-- next time this causes an issue, see https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support

require('nvim-treesitter.configs').setup {
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
}

require('treesitter-context').setup { separator = '-' }

require('nvim-ts-autotag').setup({
  aliases = {
    ["elixir"] = "html"
  }
})
