return {
  'saghen/blink.cmp',
  lazy = false, -- lazy loading handled internally
  version = 'v0.*',

  dependencies = { 'kristijanhusak/vim-dadbod-completion' },

  opts = {
    keymap = { preset = 'default' },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev', 'dadbod' },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
        dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
      },
      cmdline = { enabled = false },
    },

    signature = { enabled = true },

    completion = {
      list = { selection = { auto_insert = true } },
      accept = {
        auto_brackets = { enabled = true },
      },
      menu = {
        draw = {
          treesitter = { 'lsp' },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
        update_delay_ms = 0,
      },
    },
  },
}
