local js_formatters = { 'prettierd' }

require('conform').setup {
  formatters_by_ft = {
    python = { 'isort', 'black' },

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

require('lint').linters_by_ft = {
  python = { 'ruff' },
}

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'TextChanged' }, {
  callback = function() require('lint').try_lint() end,
})
