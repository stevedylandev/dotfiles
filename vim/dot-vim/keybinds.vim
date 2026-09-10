let mapleader = " "

noremap <leader>e :Ex<CR>
noremap <leader>h :noh<CR>
noremap <S-l> :bnext<CR>
noremap <S-h> :bprevious<CR>
noremap <leader>c :bd<CR>
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

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
