-- Set colorscheme
require('tokyonight').setup({
  style = 'moon', -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  transparent = true, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    comments = { italic = false },
    keywords = { italic = false },
  },
})

-- set colorscheme after options
vim.o.termguicolors = true
vim.cmd('colorscheme tokyonight')
--  Colored line number without cursorline background
vim.cmd('highlight CursorLine guibg=None')
vim.cmd('highlight CursorLineNR guibg=None')
--  Use the terminal's background color. Useful for transparency.
vim.cmd('highlight Normal guibg=none')
