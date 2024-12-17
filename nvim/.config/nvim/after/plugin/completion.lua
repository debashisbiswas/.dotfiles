-- Note on completion/snippets: I tried mini.completion for a bit, but ran into
-- an issue on snippets. It doesn't support snippet expansion - which would be
-- fine - but this also means it doesn't support LSP-provided snippets. These
-- are snippets such as the postfix snippets provided by rust-analyzer. It
-- seems the best way to support LSP provided snippets at this point is to use
-- nvim-cmp with LuaSnip, so that's what I'm doing. mini.completion was nice
-- though.
--
-- Maybe blink supports LSP snippets! We'll see.

require('nvim-autopairs').setup {}
