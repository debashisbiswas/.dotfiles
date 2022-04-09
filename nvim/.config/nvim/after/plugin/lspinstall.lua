local lsp_installer = require "nvim-lsp-installer"

-- Include the servers you want to have installed by default below
local servers = {
  "bashls",
  "jedi_language_server",
  "rust_analyzer",
  "yamlls",
  "cssls",
  "eslint",
  "emmet_ls",
  "html",
  "jsonls",
  "tsserver",
  "svelte",
  "taplo",
  "vimls",
  "lemminx",
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end
end

function common_on_attach(client, bufnr)
  -- add your code here
end

-- TODO: should capabilities be installed for every server?
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = common_on_attach,
  }

  if server.name == "eslint" then
    opts.on_attach = function (client, bufnr)
      -- neovim's LSP client does not currently support dynamic capabilities registration, so we need to set
      -- the resolved capabilities of the eslint server ourselves!
      client.resolved_capabilities.document_formatting = true
      common_on_attach(client, bufnr)
    end

    opts.settings = {
      format = { enable = true }, -- this will enable formatting
    }
  end


  -- This setup() function will take the provided server configuration and decorate it with the necessary properties
  -- before passing it onwards to lspconfig.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end)
