" Vim has no built-in .mdx detection, so map it onto markdown while keeping
" an mdx component for filetype-specific autocommands and plugins.
augroup filetypedetect_mdx
  autocmd!
  autocmd BufNewFile,BufRead *.mdx setfiletype markdown.mdx
augroup END

" Prose files: soft wrap at word boundaries, spell check
augroup prose_settings
  autocmd!
  autocmd FileType markdown,mdx,text call s:ProseSettings()
augroup END

function! s:ProseSettings() abort
  setlocal wrap
  setlocal linebreak " Break at word boundaries
  setlocal spell
endfunction
