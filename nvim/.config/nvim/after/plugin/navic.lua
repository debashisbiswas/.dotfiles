local navic = require 'nvim-navic'

navic.setup {
  separator = ' > ',
  depth_limit = 5,
  -- stylua: ignore
  icons = {
    File        = '', Module        = '',
    Namespace   = '', Package       = '',
    Class       = '', Method        = '',
    Property    = '', Field         = '',
    Constructor = '', Enum          = '',
    Interface   = '', Function      = '',
    Variable    = '', Constant      = '',
    String      = '', Number        = '',
    Boolean     = '', Array         = '',
    Object      = '', Key           = '',
    Null        = '', EnumMember    = '',
    Struct      = '', Event         = '',
    Operator    = '', TypeParameter = '',
  },
}