require('catppuccin').setup {
  flavour = 'mocha', -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = 'latte',
    dark = 'mocha',
  },
  transparent_background = true, -- disables setting the background color.
  show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
  term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
  no_italic = true,
  styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
    -- Remove italics
    comments = {},
    conditionals = {},
  },
  highlight_overrides = {
    macchiato = function(macchiato)
      return {
        LineNr = { fg = macchiato.surface2 },
      }
    end,
    mocha = function(mocha)
      return {
        LineNr = { fg = mocha.surface2 },
      }
    end,
  },
}

vim.cmd('colorscheme catppuccin')
