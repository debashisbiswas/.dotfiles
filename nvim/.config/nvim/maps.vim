" Harpoon
" m for mark, gfdsa on left hand
nnoremap <silent><Leader>m :lua require("harpoon.mark").add_file()<CR>
nnoremap <silent><Leader>g :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <silent><Leader>f :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <silent><Leader>d :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <silent><Leader>s :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <silent><Leader>a :lua require("harpoon.ui").nav_file(4)<CR>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
