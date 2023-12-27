local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

vim.keymap.set({ 'i' }, '<C-K>', function()
  luasnip.expand_or_jump()
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<C-J>', function()
  luasnip.jump(-1)
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<C-L>', function()
  if luasnip.choice_active() then
    luasnip.change_choice(1)
  end
end, { silent = true })
