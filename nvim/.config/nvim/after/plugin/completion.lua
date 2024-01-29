-- Note on completion/snippets: I tried mini.completion for a bit, but ran into
-- an issue on snippets. It doesn't support snippet expansion - which would be
-- fine - but this also means it doesn't support LSP-provided snippets. These
-- are snippets such as the postfix snippets provided by rust-analyzer. It
-- seems the best way to support LSP provided snippets at this point is to use
-- nvim-cmp with LuaSnip, so that's what I'm doing. mini.completion was nice
-- though.

local cmp = require 'cmp'
local compare = cmp.config.compare
local luasnip = require 'luasnip'

-- from 'lukas-reineke/cmp-under-comparator'
local function under(entry1, entry2)
  local _, entry1_under = entry1.completion_item.label:find '^_+'
  local _, entry2_under = entry2.completion_item.label:find '^_+'
  entry1_under = entry1_under or 0
  entry2_under = entry2_under or 0
  if entry1_under > entry2_under then
    return false
  elseif entry1_under < entry2_under then
    return true
  end
end

cmp.setup {
  preselect = 'None',

  formatting = {
    format = require('tailwindcss-colorizer-cmp').formatter,
  },

  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-Space>'] = cmp.mapping.complete(),

    ['<C-y>'] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { 'i', 'c' }
    ),
  },

  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'path' },
  }, {
    { name = 'buffer' },
  }),

  sorting = {
    priority_weight = 2,
    comparators = {
      compare.offset,
      compare.exact,
      compare.scopes,
      compare.score,
      compare.recently_used,
      under,
      compare.locality,
      compare.kind,
      compare.sort_text,
      compare.length,
      compare.order,
    },
  },
}

require('nvim-autopairs').setup {}
cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())
