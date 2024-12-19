return {
  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
    opts = {
      palettes = {
        carbonfox = {
          sel0 = '#3a3a3a', -- Popup bg, visual selection bg
        },
      },
    },
    config = function(_, opts)
      require('nightfox').setup(opts)
      vim.cmd [[colorscheme carbonfox]]
    end,
  },
  {
    'brenoprata10/nvim-highlight-colors',
    opts = {
      render = 'background',
      enable_tailwind = true,
    },
  },
}
