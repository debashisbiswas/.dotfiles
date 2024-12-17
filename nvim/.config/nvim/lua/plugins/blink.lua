return {
  'saghen/blink.cmp',
  lazy = false, -- lazy loading handled internally
  version = 'v0.*',

  opts = {
    keymap = { preset = 'default' },

    -- default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, via `opts_extend`
    sources = {
      -- TODO: not understanding what default is used for
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      completion = {
        enabled_providers = { "lsp", "path", "snippets", "buffer", "dadbod" },
      },
      providers = {
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
      },
    },

    signature = { enabled = true },

    completion = {
      list = { selection = 'auto_insert' },
      accept = {
        auto_brackets = { enabled = true },
      },
      menu = {
        draw = {
          treesitter = { 'lsp' }
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      }
    }
  },

  -- allows extending the providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { "sources.default" }
}
