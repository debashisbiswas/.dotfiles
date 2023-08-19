-- avoiding treesitter-angular as it breaks TS files
-- next time this causes an issue, see https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support

-- I've had a better experience on windows with clang, less breakage
if vim.fn.has 'win32' == 1 then
  require('nvim-treesitter.install').compilers = { 'clang', 'gcc' }
end

require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'lua' },

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  indent = { enable = true },

  highlight = {
    enable = true,
    disable = { 'lua' }, -- lua has semantic highlighting through the LSP
  },
}
