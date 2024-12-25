return {
  'stevearc/oil.nvim',
  lazy = false, -- need available from the CLI
  opts = {
    view_options = { show_hidden = true },
  },
  keys = {
    { '-', '<CMD>Oil<CR>', desc = 'Open parent directory' },
  },
}
