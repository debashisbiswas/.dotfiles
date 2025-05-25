return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'b0o/schemastore.nvim',
    },
    config = function()
      -- Set up borders for LSP windows
      -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization

      local lspconfig = require 'lspconfig'
      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or 'rounded'
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end

      vim.diagnostic.config { float = { source = true } }

      local on_attach = function(client, bufnr)
        local nmap = function(keys, func, desc)
          if desc then desc = 'LSP: ' .. desc end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', function() require('fzf-lua').lsp_code_actions() end, '[C]ode [A]ction')

        nmap('gd', function() require('fzf-lua').lsp_definitions() end, '[G]oto [D]efinition')
        nmap(
          'gr',
          function() require('fzf-lua').lsp_references { path_display = { 'smart' } } end,
          '[G]oto [R]eferences'
        )
        nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        nmap('<leader>ds', function() require('fzf-lua').lsp_document_symbols() end, '[D]ocument [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      end

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local servers = require 'plugins.lsp.servers'
      for _, server_config in ipairs(servers) do
        local server_name, config

        if type(server_config) == 'string' then
          server_name = server_config
          config = {}
        else
          server_name = server_config[1]
          config = server_config
        end

        lspconfig[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = config.settings,
          filetypes = config.filetypes,
          cmd = config.cmd,
        }
      end
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {}

      vim.keymap.set({ 'i' }, '<C-K>', function() luasnip.expand_or_jump() end, { silent = true })

      vim.keymap.set({ 'i', 's' }, '<C-J>', function() luasnip.jump(-1) end, { silent = true })

      vim.keymap.set({ 'i', 's' }, '<C-L>', function()
        if luasnip.choice_active() then luasnip.change_choice(1) end
      end, { silent = true })
    end,
  },
}
