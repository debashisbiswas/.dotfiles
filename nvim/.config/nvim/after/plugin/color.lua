require('nightfox').setup {
  palettes = {
    carbonfox = {
      sel0 = '#3a3a3a', -- Popup bg, visual selection bg
    },
  },
}

vim.cmd 'colorscheme carbonfox'

vim.opt.termguicolors = true
require('nvim-highlight-colors').setup({
  render = 'background',
  enable_tailwind = true,
})
