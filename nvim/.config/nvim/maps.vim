map <Leader>h :wincmd h<CR>
map <Leader>j :wincmd j<CR>
map <Leader>k :wincmd k<CR>
map <Leader>l :wincmd l<CR>

nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>
nnoremap <Leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <Leader>vc :lua require('telescope.builtin').git_files({ prompt_title = "< VimRC >", cwd = vim.env.DOTFILES, hidden = true })<CR>
nnoremap <Leader>so :so %<CR>

" Harpoon
nnoremap <Leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <Leader>tc :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>
nnoremap <> :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <> :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <> :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <> :lua require("harpoon.ui").nav_file(4)<CR>

command! PI PlugInstall
command! PU PlugUpdate | PlugUpgrade
