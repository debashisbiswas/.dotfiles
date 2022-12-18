-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

vim.o.scrolloff = 8
vim.o.showmode = false
vim.o.tabstop = 4

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap.set
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
keymap('n', '<Leader>h', '<C-w>h')
keymap('n', '<Leader>j', "<C-w>j")
keymap('n', '<Leader>k', "<C-w>k")
keymap('n', '<Leader>l', "<C-w>l")
keymap('n', '<Leader>t', ":Lex 20<CR>")

keymap('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })
keymap('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Harpoon
-- m for mark, gfdsa on left hand
keymap("n", "<Leader>m", require("harpoon.mark").add_file)
keymap("n", "<Leader>g", require("harpoon.ui").toggle_quick_menu)
keymap("n", "<Leader>f", function() require("harpoon.ui").nav_file(1) end)
keymap("n", "<Leader>d", function() require("harpoon.ui").nav_file(2) end)
keymap("n", "<Leader>s", function() require("harpoon.ui").nav_file(3) end)
keymap("n", "<Leader>a", function() require("harpoon.ui").nav_file(4) end)

-- Telescope
-- See `:help telescope.builtin`
keymap('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
keymap('n', '<leader><leader>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
keymap('n', '<C-p>', require('telescope.builtin').git_files, { desc = 'Git Files' })
keymap('n', '<leader>pf', require('telescope.builtin').find_files, { desc = '[P]roject [F]iles' })
keymap('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
keymap('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
keymap('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
keymap('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
keymap('n', '<leader>vc', require('telescope.builtin').commands, { desc = '[V]iew [C]ommands' })
keymap('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

local autocmd_group = vim.api.nvim_create_augroup('MaestosoCommands', { clear = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  group = autocmd_group,
  callback = function()
    vim.highlight.on_yank({ timeout = 40 })
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  group = autocmd_group,
  command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  group = autocmd_group,
  callback = function()
    keymap('', 'q', ':q<CR>', { buffer = true })
  end,
})
