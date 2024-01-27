-- Set up borders for LSP windows
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
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
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap(
    'gr',
    function() require('telescope.builtin').lsp_references { path_display = { 'smart' } } end,
    '[G]oto [R]eferences'
  )
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap(
    '<leader>wl',
    function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
    '[W]orkspace [L]ist Folders'
  )

  -- TODO: https://www.reddit.com/r/neovim/comments/10a31vo/how_does_vimlspbufformat_deal_with_multiple/
  local do_format = function(async)
    vim.lsp.buf.format {
      filter = function(client)
        -- TODO: should use these as fallbacks when the main formatter is not available
        return client.name ~= 'lua_ls' and client.name ~= 'tsserver'
      end,
      async = async,
    }
  end

  vim.keymap.set(
    'n',
    '<leader>;',
    function() require('conform').format { lsp_fallback = true } end,
    { desc = 'Format buffer' }
  )
end

local servers = {
  clangd = {},
  rust_analyzer = {},
  tsserver = {},
  gopls = {},

  emmet_language_server = {},

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

  stylelint_lsp = {
    stylelintplus = {
      autoFixOnFormat = true,
    },
  },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require('neodev').setup {}

--------------------
-- Mason
--------------------

require('mason').setup()
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

require('fidget').setup {}
