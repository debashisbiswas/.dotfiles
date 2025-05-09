local js_formatters = { 'prettierd' }

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function() require('conform').format() end,
      desc = 'Format buffer',
    },
  },
  opts = {
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

      nix = { 'nixpkgs_fmt' },
    },
  },
  config = function(_, opts)
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

    require('conform').setup(opts)
  end,
}
