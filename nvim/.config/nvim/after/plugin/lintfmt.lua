local js_formatters = { 'prettierd', 'eslint_d' }

require('conform').setup {
  formatters_by_ft = {
    python = function(bufnr)
      if require('conform').get_formatter_info('ruff_format', bufnr).available then
        return { 'ruff_format' }
      else
        return { 'isort', 'black' }
      end
    end,

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
  },
}

local js_linters = { 'eslint_d' }

require('lint').linters_by_ft = {
  python = { 'ruff' },

  typescript = js_linters,
  javascript = js_linters,
  typescriptreact = js_linters,
  javascriptreact = js_linters,

  astro = js_linters,
  svelte = js_linters,
}

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'TextChanged' }, {
  callback = function()
    require('lint').try_lint()
  end,
})
