return {
  'nvim-lualine/lualine.nvim',
  init = function() vim.o.showmode = false end,
  opts = {
    options = {
      icons_enabled = false,
      component_separators = '',
      section_separators = '',
    },
    sections = {
      lualine_a = { { 'mode', fmt = function(str) return str:sub(1, 1) end } },
      lualine_b = { 'filename' },
      lualine_c = { 'branch', 'diff', 'diagnostics' },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
  },
}
