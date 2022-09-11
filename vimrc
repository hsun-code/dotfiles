set nu
set autoindent
set cindent
set smartindent

" syntan high-light
syntax on

set showmode

imap { {<CR>}<Esc>kA<CR>

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

set hlsearch
set incsearch

if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

au FileType gitcommit setlocal tw=72

set cul

set ignorecase

