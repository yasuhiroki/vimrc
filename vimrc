"-------------------------------------------------------------------------------
" Plugin Management {{{1
"-------------------------------------------------------------------------------
filetype off
set nocompatible               " Be iMproved

"--------------------------------------
" NeoBundle Plugin {{{2
"--------------------------------------
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

"--------------------------------------
" Plugin for file exproler {{{2
"--------------------------------------
" ctrlp.vim
NeoBundle 'git://github.com/kien/ctrlp.vim.git'
if neobundle#is_installed('ctrlp.vim')
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
endif

" NERD Tree
NeoBundle 'git://github.com/scrooloose/nerdtree.git'

"--------------------------------------
" Plugin for git {{{2
"--------------------------------------
NeoBundle 'git://github.com/tpope/vim-fugitive.git'
NeoBundle 'git://github.com/gregsexton/gitv.git'
autocmd FileType git :setlocal foldlevel=99

"--------------------------------------
" Plugin for programing {{{2
"--------------------------------------
" vim-quickrun
NeoBundle 'git://github.com/thinca/vim-quickrun.git'

" vim-indent-guides
NeoBundle 'git://github.com/nathanaelkane/vim-indent-guides.git'
colorscheme default
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=DarkRed ctermbg=darkgray
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  guibg=DarkGreen ctermbg=darkcyan
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1

" static analyzer
NeoBundle 'git://github.com/scrooloose/syntastic.git'

" python 
NeoBundle 'nvie/vim-flake8'
NeoBundle 'git://github.com/alfredodeza/pytest.vim.git'

"--------------------------------------
" Plugin for write text docment or novel {{{2
"--------------------------------------
NeoBundle 'git://github.com/fuenor/JpFormat.vim.git'

"--------------------------------------
" Plugin for buffer {{{2
"--------------------------------------
" buftabs
NeoBundle 'vim-scripts/buftabs'

let g:buftabs_only_basename = 1
let g:buftabs_in_statusline = 1
let g:buftabs_active_highlight_group="Visual"

"-------------------------------------------------------------------------------
" basic settings {{{1
"-------------------------------------------------------------------------------
set encoding=utf8
set scrolloff=5

"-------------------------------------------------------------------------------
" Text, tab and indent settings {{{1
"-------------------------------------------------------------------------------
set shiftwidth=4
set tabstop=4
set smarttab
set expandtab
set autoindent
set wrap
set number

"-------------------------------------------------------------------------------
" status line settings {{{1
"-------------------------------------------------------------------------------
set statusline=%=\ [%{(&fenc!=''?&fenc:&enc)}/%{&ff}]\[%Y]\[%04l,%03v][%p%%]
set laststatus=2

"-------------------------------------------------------------------------------
" Key mapping {{{1
"-------------------------------------------------------------------------------
"--------------------------------------
" Key mapping for plugin {{{2
"--------------------------------------
" <Space>. : open .vimrc
nnoremap <Space>. :<C-u>tabedit $MYVIMRC<CR>

" <Ctrl> + p : Using ctrlp
let g:ctrlp_map = '<c-p>'

" If filetype is text or novela, <Leader>g : Count manuscript paper
noremap <Leader>g :JpCountPages 20 20 <Return>

"--------------------------------------
" Key mapping for buffer {{{2
"--------------------------------------
map <F3> <ESC>:bn<CR>

"-------------------------------------------------------------------------------
" Other {{{1
"-------------------------------------------------------------------------------
set foldmethod=marker

filetype plugin indent on
filetype on
