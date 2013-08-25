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
" Plugin for unite interface {{{2
"--------------------------------------
NeoBundle 'https://github.com/Shougo/unite.vim'
NeoBundle 'https://github.com/ujihisa/unite-colorscheme'

"--------------------------------------
" Plugin vim-proc {{{2
"--------------------------------------
" vimproc
NeoBundle "https://github.com/Shougo/vimproc.vim.git", {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

"--------------------------------------
" Plugin vim-shell {{{2
"--------------------------------------
NeoBundle "https://github.com/Shougo/vimshell.vim.git"

"--------------------------------------
" Plugin complcache {{{2
"--------------------------------------
NeoBundle "https://github.com/Shougo/neocomplcache.vim.git"


"--------------------------------------
" Plugin for file exproler {{{2
"--------------------------------------
" ctrlp.vim
NeoBundle 'https://github.com/kien/ctrlp.vim.git'
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
NeoBundle 'https://github.com/scrooloose/nerdtree.git'

"--------------------------------------
" Plugin for git {{{2
"--------------------------------------
NeoBundle 'https://github.com/tpope/vim-fugitive.git'
NeoBundle 'https://github.com/gregsexton/gitv.git'
autocmd FileType git :setlocal foldlevel=99

"--------------------------------------
" Plugin for programing {{{2
"--------------------------------------
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

" static analyzer
NeoBundle 'https://github.com/scrooloose/syntastic.git'

" python 
NeoBundle 'https://github.com/nvie/vim-flake8'
NeoBundle 'https://github.com/alfredodeza/pytest.vim.git'

"--------------------------------------
" Plugin for write text docment or novel {{{2
"--------------------------------------
NeoBundle 'https://github.com/fuenor/JpFormat.vim.git'

"--------------------------------------
" Plugin for buffer {{{2
"--------------------------------------
" buftabs
NeoBundle 'https://github.com/vim-scripts/buftabs'

let g:buftabs_only_basename = 1
let g:buftabs_in_statusline = 1
let g:buftabs_active_highlight_group="Visual"

"-------------------------------------------------------------------------------
" basic settings {{{1
"-------------------------------------------------------------------------------
set encoding=utf8
set scrolloff=5
set backup
set swapfile
set backupdir=~/.vim/backup
set directory=~/.vim/swap

"-------------------------------------------------------------------------------
" Text, tab and indent settings {{{1
"-------------------------------------------------------------------------------
set shiftwidth=4
set tabstop=4
set smarttab
set expandtab
set autoindent

"-------------------------------------------------------------------------------
" Display settings {{{1
"-------------------------------------------------------------------------------
set wrap
set number
set title
set ruler


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
map <F4> <ESC>:bp<CR>

"--------------------------------------
" Key mapping for comment out {{{2
"--------------------------------------
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

"--------------------------------------
" Key mapping for vim preparing {{{2
"--------------------------------------

"-------------------------------------------------------------------------------
" Other {{{1
"-------------------------------------------------------------------------------
set foldmethod=marker

"--------------------------------------
" Colorscheme {{{2
"--------------------------------------
NeoBundle 'https://github.com/altercation/vim-colors-solarized'
"syntax on
set t_Co=256
set background=dark
colorscheme solarized
let g:solarized_termcolors=256
syntax enable
"let g:solarized_termtrans=1

"-------------------------------------------------------------------------------
" Origin Tools {{{1
"-------------------------------------------------------------------------------
function! DisplayCreator(mode)  "{{{2

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


"-------------------------------------------------------------------------------
" file type on {{{1
"-------------------------------------------------------------------------------
filetype plugin indent on
filetype on
