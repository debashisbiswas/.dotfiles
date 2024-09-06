vim.o.timeout = true
vim.o.timeoutlen = 300

local wk = require('which-key')

wk.setup {
  preset = 'modern',
  icons = { mappings = false }
}

wk.add {
  { "<leader>",  group = "leader" },
  { "<leader>a", group = "append" },
  { "<leader>b", group = "buffer" },
  { "<leader>c", group = "code" },
  { "<leader>g", group = "git" },
  { "<leader>h", group = "hunk" }, -- this should be the help page!
  { "<leader>j", group = "jump" },
  { "<leader>m", group = "localleader" },
  { "<leader>s", group = "search" },
  { "<leader>v", group = "vim" },
  { "<leader>w", group = "workspace" }
}
