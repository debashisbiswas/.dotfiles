return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'fidget.nvim',
      'b0o/schemastore.nvim',

      {
        'williamboman/mason.nvim',
        keys = {
          { '<leader>vm', '<Cmd>Mason<CR>', desc = '[v]im: [m]ason' },
        },
      },
      'williamboman/mason-lspconfig.nvim',
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

      vim.diagnostic.config {
        float = {
          source = 'always',
          header = 'Diagnostics',
        },
      }

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

      local servers = {
        clangd = {},
        rust_analyzer = {},
        ts_ls = {},
        gopls = {},

        tailwindcss = {
          tailwindCSS = {
            includeLanguages = {
              elixir = 'html-eex',
              eelixir = 'html-eex',
              heex = 'html-eex',
            },
          },
        },

        emmet_language_server = {
          filetypes = { 'css', 'html', 'javascriptreact', 'typescriptreact', 'heex' },
        },

        eslint = {},

        html = {
          html = {
            format = {
              indentInnerHtml = true,
            },
          },
        },

        cssls = {},

        pyright = {
          python = {
            analysis = {
              diagnosticMode = 'workspace',
            },
          },
        },

        jsonls = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },

        yamlls = {
          yaml = {
            schemaStore = {
              -- You must disable built-in schemaStore support if you want to use
              -- this plugin and its advanced options like `ignore`.
              enable = false,
            },
            schemas = require('schemastore').yaml.schemas(),
          },
        },

        lua_ls = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local function set_up_server(server_name)
        lspconfig[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        }
      end

      --------------------
      -- Mason
      --------------------

      require('mason').setup()

      -- Someday I won't have to use Windows, but this is staying for now
      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup {}
      mason_lspconfig.setup_handlers { function(name) set_up_server(name) end }

      set_up_server 'astro'
      set_up_server 'gleam'
      set_up_server 'nixd'
      set_up_server 'eslint'
      set_up_server 'svelte'
      set_up_server 'zls'
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
