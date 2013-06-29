"-------------------------------------------------------------------------------
" Plugin Management
"-------------------------------------------------------------------------------
filetype off
set nocompatible               " Be iMproved

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" vim-quickrun
NeoBundle 'https://github.com/thinca/vim-quickrun.git'

" vim-indent-guides
NeoBundle 'https://github.com/nathanaelkane/vim-indent-guides.git'
colorscheme default
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=DarkRed ctermbg=darkgray
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  guibg=DarkGreen ctermbg=darkcyan
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1


"--------------------------------------
" Plugin for file exproler
"--------------------------------------
" ctrlp.vim
NeoBundle 'https://github.com/kien/ctrlp.vim.git'
let g:ctrlp_use_migemo = 1
let g:ctrlp_clear_cache_on_exit = 0   " Doesn't cache clear when vim quit
let g:ctrlp_mruf_max            = 500 " Max memorable mru
let g:ctrlp_open_new_file       = 1   " Open new file as tab
let g:ctrlp_buffer_func = {
    \ 'enter': 'Ctrlp_laststatus_0',
    \ 'exit':  'Ctrlp_laststatus_2',
    \ }
func! Ctrlp_laststatus_0()
    set laststatus=0
endfunc
func! Ctrlp_laststatus_2()
    set laststatus=2
endfunc

" NERD Tree
NeoBundle 'https://github.com/scrooloose/nerdtree.git'

"--------------------------------------
" Plugin for git
"--------------------------------------
NeoBundle 'https://github.com/tpope/vim-fugitive.git'
NeoBundle 'https://github.com/tpope/vim-fugitive.gi://github.com/gregsexton/gitv.git'


"--------------------------------------
" Plugin for programing
"--------------------------------------
NeoBundle 'https://github.com/scrooloose/syntastic.git'

" python 
NeoBundle 'nvie/vim-flake8'

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
set number

"-------------------------------------------------------------------------------
" Key mapping
"-------------------------------------------------------------------------------
" <Space>. : open .vimrc
nnoremap <Space>. :<C-u>tabedit $MYVIMRC<CR>

" <Ctrl> + p : Using ctrlp
let g:ctrlp_map = '<c-p>'

"-------------------------------------------------------------------------------
" 
"-------------------------------------------------------------------------------


