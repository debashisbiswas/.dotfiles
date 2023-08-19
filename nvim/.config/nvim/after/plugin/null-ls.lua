local null_ls = require 'null-ls'

-- stylua: ignore
local prettier_root_files = {
  '.prettierrc',    '.prettierrc.json', '.prettierrc.yml',  '.prettierrc.yaml',   '.prettierrc.json5',
  '.prettierrc.js', '.prettierrc.cjs',  '.prettierrc.toml', 'prettier.config.js', 'prettier.config.cjs',
}

local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

null_ls.setup {
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
