return {
  'supermaven-inc/supermaven-nvim',
  enabled = not os.getenv 'IS_WORK_MACHINE',
  lazy = false,
  opts = {
    keymaps = {
      accept_suggestion = '<M-l>',
      accept_word = '<M-j>',
    },
    ignore_filetypes = { 'markdown' },
  },
}
