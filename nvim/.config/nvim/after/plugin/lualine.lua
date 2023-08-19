require('lualine').setup {
  options = {
    icons_enabled = false,
    component_separators = '|',
    section_separators = '',
  },
  sections = {
    lualine_c = {
      { 'filename' },
      {
        function()
          return require('nvim-navic').get_location()
        end,
        cond = function()
          return package.loaded['nvim-navic'] and require('nvim-navic').is_available()
        end,
      },
    },
  },
}
