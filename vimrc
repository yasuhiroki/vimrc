"-------------------------------------------------------------------------------
" Plugin Management
"-------------------------------------------------------------------------------
filetype off
set nocompatible               " Be iMproved

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundle 'https://github.com/thinca/vim-quickrun.git'

filetype on


"-------------------------------------------------------------------------------
" basic settings
"-------------------------------------------------------------------------------
set encoding=utf8
set scrolloff=5


"-------------------------------------------------------------------------------
" Text, tab and indent settings
"-------------------------------------------------------------------------------
set shiftwidth=4
set tabstop=4
set smarttab
set expandtab
set autoindent
set wrap
