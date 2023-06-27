return {
  -- avoidng treesitter-angular as it breaks TS files
  -- next time this causes an issue, see https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup {
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = 'all',

      -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      auto_install = false,

      indent = { enable = true, disable = { 'python' } },

      highlight = {
        enable = true,
      },
    }
  end,
}
