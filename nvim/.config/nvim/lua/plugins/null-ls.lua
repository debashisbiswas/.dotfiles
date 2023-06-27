return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = function()
    local null_ls = require 'null-ls'

    return {
      sources = {
        null_ls.builtins.completion.spell,
        -- null_ls.builtins.diagnostics.eslint.with {
        --   extra_filetypes = { 'astro', 'svelte' },
        --   condition = function(utils)
        --     return utils.root_has_file {
        --       '.eslintrc.js',
        --       '.eslintrc.cjs',
        --       '.eslintrc.yaml',
        --       '.eslintrc.yml',
        --       '.eslintrc.json',
        --     }
        --   end,
        -- },
        null_ls.builtins.diagnostics.fish,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.fish_indent,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.prettierd.with {
          extra_filetypes = { 'astro', 'svelte' },
          condition = function(utils)
            return utils.root_has_file {
              '.prettierrc',
              '.prettierrc.json',
              '.prettierrc.yml',
              '.prettierrc.yaml',
              '.prettierrc.json5',
              '.prettierrc.js',
              '.prettierrc.cjs',
              '.prettierrc.toml',
              'prettier.config.js',
              'prettier.config.cjs',
            }
          end,
        },
        null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.formatting.stylua,
      },
    }
  end,
}
