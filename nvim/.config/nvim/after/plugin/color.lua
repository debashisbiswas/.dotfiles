require('nightfox').setup {
  palettes = {
    carbonfox = {
      sel0 = '#3e4a5b', -- Popup bg, visual selection bg
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
