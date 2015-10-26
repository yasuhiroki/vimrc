"==============================================================================
" FILE: vimrc
"==============================================================================
" Plugin Management
"  Using NeoBundle to magnage plugins.
"------------------------------------------------------------------------------
"
" NeoBundle {{{1
filetype off
set nocompatible               " Be proved
if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


" }}}

" Plugins {{{1

call neobundle#begin(expand('~/.vim/bundle/'))

runtime! my_conf/*.vim

"------------------------------------------------------------------------------
" Plugin for interface
"------------------------------------------------------------------------------
" Plugin vim-proc
NeoBundle "https://github.com/Shougo/vimproc.vim.git", {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
	  \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

" Plugin vim-shell
NeoBundle "https://github.com/Shougo/vimshell.vim.git"

"------------------------------------------------------------------------------
" Plugin for programing
"------------------------------------------------------------------------------
" vim-quickrun
NeoBundle 'https://github.com/thinca/vim-quickrun.git'
let g:quickrun_config = {
    \ "*": {"runner": "vimproc"},
    \ }

" static analyzer
NeoBundle 'https://github.com/scrooloose/syntastic.git'

" endwise
NeoBundle 'https://github.com/tpope/vim-endwise'

"------------------------------------------------------------------------------
" Plugin for write text docment
"------------------------------------------------------------------------------
" Genko pages counter
NeoBundle 'https://github.com/fuenor/JpFormat.vim.git'

call neobundle#end()

syntax enable
set t_Co=256
set background=light
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized

" }}}
"==============================================================================
" settings {{{
"------------------------------------------------------------------------------
" basic settings
"------------------------------------------------------------------------------
set encoding=utf8
set scrolloff=5
set backup
set swapfile
set backupdir=~/.vim/backup
set directory=~/.vim/swap

"------------------------------------------------------------------------------
" Text, tab and indent settings
"------------------------------------------------------------------------------
set shiftwidth=4
set tabstop=4
set smarttab
set expandtab
set autoindent
autocmd FileType text setlocal textwidth=0

"------------------------------------------------------------------------------
" Display settings
"------------------------------------------------------------------------------
set wrap
set number
set title
set ruler
set hlsearch

"------------------------------------------------------------------------------
" status line settings
"------------------------------------------------------------------------------
set statusline=%=\ [%{(&fenc!=''?&fenc:&enc)}/%{&ff}]\[%Y]\[%04l,%03v][%p%%]
set laststatus=2

"------------------------------------------------------------------------------
" Other
"------------------------------------------------------------------------------
set foldmethod=marker

" }}}
"==============================================================================
" Key mapping {{{
"------------------------------------------------------------------------------
" Key mapping for plugin
"------------------------------------------------------------------------------
" <Space>. : open .vimrc
nnoremap <Space>. :<C-u>tabedit $MYVIMRC<CR>

"------------------------------------------------------------------------------
" If filetype is text or novela, <Leader>g : Count manuscript paper
"------------------------------------------------------------------------------
noremap <Leader>g :JpCountPages 20 20 <Return>

"------------------------------------------------------------------------------
" Key mapping for buffer
"------------------------------------------------------------------------------
map <F3> <ESC>:bn<CR>
map <F4> <ESC>:bp<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"------------------------------------------------------------------------------
" Key mapping for comment out
"------------------------------------------------------------------------------
" lhs comments
vmap ,# :s/^/#/<CR>:nohlsearch<CR>
vmap ,/ :s/^/\/\//<CR>:nohlsearch<CR>
vmap ,> :s/^/> /<CR>:nohlsearch<CR>
vmap ," :s/^/\"/<CR>:nohlsearch<CR>
vmap ,% :s/^/%/<CR>:nohlsearch<CR>
vmap ,! :s/^/!/<CR>:nohlsearch<CR>
vmap ,; :s/^/;/<CR>:nohlsearch<CR>
vmap ,- :s/^/-- /<CR>:nohlsearch<CR>
vmap ,c :s/^\(\s*\)\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>
" wrapping comments
vmap ,* :s/^\(.*\)$/\/\* \1 \*\//<CR>:nohlsearch<CR>
vmap ,( :s/^\(.*\)$/\(\* \1 \*\)/<CR>:nohlsearch<CR>
vmap ,< :s/^\(.*\)$/<!-- \1 -->/<CR>:nohlsearch<CR>
vmap ,d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR>:nohlsearch<CR> 
" block comments
vmap ,b v`<I<CR><esc>k0i/*<ESC>`>j0i*/<CR><esc><ESC>
vmap ,h v`<I<CR><esc>k0i<!--<ESC>`>j0i--><CR><esc><ESC>

"------------------------------------------------------------------------------
" Key mapping for virtual area yunk
"------------------------------------------------------------------------------
vnoremap * "zy:let @/ = @z<CR>n

"------------------------------------------------------------------------------
" Enable to read *.md file as markdown
"------------------------------------------------------------------------------
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown

" }}}
"==============================================================================
function! DisplayCreator(mode) "{{{
    if a:mode == "novel"
        :only

        let l:file_name = expand("%:r")
        let l:memo_file = file_name . "_memo.txt"
        let l:abstract_file = file_name . "_abstract.txt"
        execute "40vnew ".memo_file
        execute "15new ".abstract_file

        call feedkeys("\<C-w>\<C-l>")
    elseif a:mode == "programming"    
        :only

        :NERDTree
        :Gitv
    endif

endfunction

function! ListDisplayCreator(argv, cmd, cur)
    return "
        \novel\n
        \programming\n
        \"
endfunction

command! -nargs=1 -complete=custom,ListDisplayCreator -bar DisplayPrepare :call DisplayCreator(<q-args>)
" }}}
"==============================================================================
function! TemplateReader(mode) " {{{ 

    if a:mode == "bash"
        :0r ~/.vim/template/bash.tmp
    endif

endfunction

function! ListTemplateReader(argv, cmd, cur)
    return "
        \bash\n
        \"
endfunction

command! -nargs=1 -complete=custom,ListTemplateReader -bar TemplateReader :call TemplateReader(<q-args>)
" }}}
"==============================================================================

"==============================================================================
" file type on
"-------------------------------------------------------------------------------
filetype plugin indent on
filetype on
"==============================================================================

"==============================================================================
" Optional
"-------------------------------------------------------------------------------
if has('mac')
    set imdisable
endif
"==============================================================================
