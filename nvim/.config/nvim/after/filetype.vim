" :help 43.2


augroup filetypedetect
  " This is fine for now: correctly highlights PL/SQL files. However, because
  " the filetype is not 'sql', the filetype plugin doesn't get loaded, so I
  " don't get the nice features of that plugin. Setting the filetype to 'sql'
  " and the syntax to 'plsql' doesn't fix it - still getting weird
  " highlighting.
  autocmd BufNewFile,BufRead *.pkb,*.pks setlocal filetype=plsql
augroup END
