-- Harpoon
-- m for mark, gfdsa on left hand
vim.keymap.set("n", "<Leader>m", require("harpoon.mark").add_file)
vim.keymap.set("n", "<Leader>g", require("harpoon.ui").toggle_quick_menu)
vim.keymap.set("n", "<Leader>f", function() require("harpoon.ui").nav_file(1) end)
vim.keymap.set("n", "<Leader>d", function() require("harpoon.ui").nav_file(2) end)
vim.keymap.set("n", "<Leader>s", function() require("harpoon.ui").nav_file(3) end)
vim.keymap.set("n", "<Leader>a", function() require("harpoon.ui").nav_file(4) end)
