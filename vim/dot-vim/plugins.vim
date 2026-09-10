" Declare plugin directory
let s:plugin_dir = expand('~/.vim/plugged')

" Native plugin manager
function! s:ensure(repo)
  let name = split(a:repo, '/')[-1]
  let path = s:plugin_dir . '/' . name

  if !isdirectory(path)
    if !isdirectory(s:plugin_dir)
      call mkdir(s:plugin_dir, 'p')
    endif
    execute '!git clone --depth=1 https://github.com/' . a:repo . ' ' . shellescape(path)
  endif

  execute 'set runtimepath+=' . fnameescape(path)
endfunction

" Plugins
call s:ensure('junegunn/fzf')
call s:ensure('junegunn/fzf.vim')
call s:ensure('itchyny/lightline.vim')
call s:ensure('yegappan/lsp')

" Colorscheme
call s:ensure('stevedylandev/darkmatter-nvim')
colorscheme darkmatter
