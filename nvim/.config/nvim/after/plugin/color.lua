require('nightfox').setup {
  palettes = {
    carbonfox = {
      sel0 = '#3a3a3a', -- Popup bg, visual selection bg
    },
  },
}

vim.cmd 'colorscheme carbonfox'

require('colorizer').setup {
  user_default_options = {
    -- Available modes for `mode`: foreground, background,  virtualtext
    mode = 'background',
    css = true,
    -- Available methods are false / true / "normal" / "lsp" / "both"
    -- TODO: hi
    tailwind = true,
  },
}
