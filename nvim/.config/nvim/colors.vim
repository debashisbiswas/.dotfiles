set termguicolors

let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection = '0'
set background=dark
colorscheme gruvbox

" https://www.ditig.com/256-colors-cheat-sheet
" highlight ColorColumn guibg=grey
highlight SignColumn guibg=none

" Setting the cursorline will still color the current line number.
highlight CursorLine guibg=none
highlight CursorLineNR guibg=None

" Use the terminal's background color. Useful for transparency.
" highlight Normal guibg=none

" Primeagen's settings
" highlight LineNr guifg=#ff8659
" highlight LineNr guifg=#aed75f
" highlight LineNr guifg=#5EACD3
" highlight netrwDir guifg=#5EACD3
" highlight qfFileName guifg=#AED75F
" highlight TelescopeBorder guifg=#5EACD3

" Completion colors
highlight! link CmpItemAbbr Comment
highlight! link CmpItemAbbrDeprecated Error
highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbr
highlight! link CmpItemKind Special
highlight! link CmpItemMenu NonText
