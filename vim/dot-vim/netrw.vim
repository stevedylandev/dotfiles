let g:netrw_banner = 0
let g:netrw_preview = 1
hi! link netrwMarkFile Search

function! NetrwMapping()
endfunction

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
  nmap <buffer> H u
  nmap <buffer> h -^
  nmap <buffer> l <CR>

  nmap <buffer> . gh
  nmap <buffer> P <C-w>z

  nmap <buffer> L <CR>:Lexplore<CR>
  nmap <buffer> <Leader>dd :Lexplore<CR>
endfunction

nnoremap <buffer> <TAB> mf
nnoremap <buffer> <S-TAB> mF
nnoremap <buffer> <Leader><TAB> mu
