runtime ./sets.vim

if exists('g:vscode')
  " VSCode extension
  set noloadplugins
else
  " Neovim
  runtime ./plugins.vim
  runtime ./maps.vim
  runtime ./colors.vim
endif
