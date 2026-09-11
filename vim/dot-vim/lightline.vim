set laststatus=2
let g:lightline = {
      \ 'colorscheme' : 'darkmatter',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ], [  'filetype' ] ]
      \ },
      \ 'mode_map': {
      \   'n' : 'N',
      \   'i' : 'I',
      \   'R' : 'R',
      \   'v' : 'V',
      \   'V' : 'VL',
      \   "\<C-v>": 'VB',
      \   'c' : 'C',
      \   's' : 'S',
      \   'S' : 'SL',
      \   "\<C-s>": 'SB',
      \   't' : 'T'
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename'
      \ }
      \ }

function! LightlineFilename()
  return expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunction

