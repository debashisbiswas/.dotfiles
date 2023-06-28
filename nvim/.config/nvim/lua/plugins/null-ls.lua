local prettier_root_files = {
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

return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = function()
    local null_ls = require 'null-ls'

    local diagnostics = null_ls.builtins.diagnostics
    local formatting = null_ls.builtins.formatting

    return {
      sources = {
        diagnostics.fish,
        formatting.black,
        formatting.fish_indent,
        formatting.isort,
        formatting.prettierd.with {
          extra_filetypes = { 'astro', 'svelte' },
          condition = function(utils)
            return utils.root_has_file(prettier_root_files)
          end,
        },
        formatting.rustfmt,
        formatting.stylua,
      },
    }
  end,
}
