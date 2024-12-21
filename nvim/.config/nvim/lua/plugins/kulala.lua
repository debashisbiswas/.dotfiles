return {
  {
    'mistweaverco/kulala.nvim',
    init = function()
      vim.filetype.add {
        extension = {
          http = 'http',
        },
      }
    end,
    opts = {},
  },
}
