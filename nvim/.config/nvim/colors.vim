set termguicolors

let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'
set background=dark
colorscheme gruvbox

"highlight ColorColumn ctermbg=0 guibg=grey
highlight SignColumn guibg=none
highlight CursorLineNR guibg=None
highlight Normal guibg=None
highlight Visual guibg=#444444
"highlight LineNr guifg=#5EACD3
"highlight netrwDir guifg=#5EACD3
"highlight TelescopeBorder guifg=#5EACD3

" Completion colors
highlight! link CmpItemAbbr Comment
highlight! link CmpItemAbbrDeprecated Error
highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbr
highlight! link CmpItemKind Special
highlight! link CmpItemMenu NonText

"let ayucolor="light"
let ayucolor="mirage"

let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'
