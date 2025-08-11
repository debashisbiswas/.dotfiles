return {
  'basedpyright',
  'clangd',
  'rust_analyzer',
  'vtsls',
  'gopls',
  'astro',
  'gleam',
  'nixd',
  'svelte',
  'zls',
  'eslint',
  'cssls',
  'sourcekit',
  'dartls',
  'ltex',

  {
    'tailwindcss',
    settings = {
      tailwindCSS = {
        includeLanguages = {
          elixir = 'html-eex',
          eelixir = 'html-eex',
          heex = 'html-eex',
        },
      },
    },
  },

  {
    'emmet_language_server',
    filetypes = { 'css', 'html', 'javascriptreact', 'typescriptreact', 'heex' },
  },

  {
    'html',
    settings = {
      html = {
        format = {
          indentInnerHtml = true,
        },
      },
    },
  },

  {
    'jsonls',
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  },

  {
    'yamlls',
    settings = {
      yaml = {
        schemaStore = {
          -- You must disable built-in schemaStore support if you want to use
          -- this plugin and its advanced options like `ignore`.
          enable = false,
        },
        schemas = require('schemastore').yaml.schemas(),
      },
    },
  },

  {
    'lua_ls',
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  },

  {
    'elixirls',
    cmd = { 'elixir-ls' },
  },
}
