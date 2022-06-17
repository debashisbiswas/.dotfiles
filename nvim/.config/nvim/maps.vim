map <Leader>h :wincmd h<CR>
map <Leader>j :wincmd j<CR>
map <Leader>k :wincmd k<CR>
map <Leader>l :wincmd l<CR>

nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>
nnoremap <Leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <Leader>vrc :lua require('telescope.builtin').git_files({ prompt_title = "< VimRC >", cwd = vim.env.DOTFILES, hidden = true })<CR>
nnoremap <Leader>vc :lua require('telescope.builtin').commands()<CR>
nnoremap <Leader>vb :lua require('telescope.builtin').buffers()<CR>

" Harpoon
" m for mark, gfdsa on left hand
nnoremap <Leader>m :lua require("harpoon.mark").add_file()<CR>
nnoremap <Leader>g :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>
nnoremap <Leader>f :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <Leader>d :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <Leader>s :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <Leader>a :lua require("harpoon.ui").nav_file(4)<CR>

command! Pi PlugInstall
command! Pup PlugUpdate | PlugUpgrade
command! Pc PlugClean
