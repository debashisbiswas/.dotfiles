require 'sets'
require 'autocommands'
require 'keymaps'

require('boilerplate').bootstrap_lazy()

require('lazy').setup({
  { import = 'plugins' },
}, {
  change_detection = { notify = false },
})
