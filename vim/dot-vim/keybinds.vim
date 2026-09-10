let mapleader = " "

noremap <leader>e :Ex<CR>
noremap <leader>h :noh<CR>
noremap <S-l> :bnext<CR>
noremap <S-h> :bprevious<CR>
noremap <leader>t :tabnext<CR>
noremap <leader>c :Bclose<cr>:tabclose<cr>gT
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

noremap <leader>q :e ~/buffer.md<CR>

noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" Spelling suggestions (requires fzf)
function! s:SpellReplace(word, choice) abort
  execute 'normal! ciw' . a:choice
  stopinsert
endfunction

function! s:SpellSuggest() abort
  let l:word = expand('<cword>')
  if empty(l:word)
    return
  endif
  call fzf#run(fzf#wrap({
        \ 'source': spellsuggest(l:word, 25),
        \ 'sink': function('s:SpellReplace', [l:word]),
        \ 'options': ['--prompt', 'Spelling: ' . l:word . '> ']
        \ }))
endfunction

nnoremap <silent> <leader>s :call <SID>SpellSuggest()<CR>

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction
