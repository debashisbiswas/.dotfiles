map <Leader>h :wincmd h<CR>
map <Leader>j :wincmd j<CR>
map <Leader>k :wincmd k<CR>
map <Leader>l :wincmd l<CR>

nnoremap <Leader>pv :Ex<CR>

nnoremap <silent><C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <silent><Leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <silent><Leader>pf :lua require('telescope.builtin').find_files()<CR>
nnoremap <silent><Leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <silent><Leader>vrc :lua require('telescope.builtin').git_files({ prompt_title = "< VimRC >", cwd = vim.env.DOTFILES, hidden = true })<CR>
nnoremap <silent><Leader>vc :lua require('telescope.builtin').commands()<CR>
nnoremap <silent><Leader>vb :lua require('telescope.builtin').buffers()<CR>

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

command! Pi PlugInstall
command! Pup PlugUpdate | PlugUpgrade
command! Pc PlugClean
