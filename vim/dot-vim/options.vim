filetype plugin indent on
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set number
set relativenumber
set smartindent
set showmatch
set backspace=indent,eol,start
syntax on
set termguicolors
set cursorline
set shell=/bin/zsh
set noshowmode
set signcolumn=yes
" Search Options
set hlsearch " Search highlighting
set incsearch " Incremental search
set ignorecase " Non case sensitive searching
set smartcase " Auto switch to case-sensitive if capital used

set mouse=a "Enabled mouse for scrolling
set spell
" System clipboard: * register on macOS, + when xterm_clipboard is built in
if has('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif
