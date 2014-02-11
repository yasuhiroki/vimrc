"==============================================================================
" FILE: vimrc
"==============================================================================
" Plugin Management
"  Using NeoBundle to magnage plugins.
"------------------------------------------------------------------------------
filetype off
set nocompatible               " Be proved

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Plugins {{{1
"------------------------------------------------------------------------------
" Plugin for interface
"------------------------------------------------------------------------------
NeoBundle 'https://github.com/Shougo/unite.vim'
NeoBundle 'https://github.com/ujihisa/unite-colorscheme'

" Plugin vim-proc
NeoBundle "https://github.com/Shougo/vimproc.vim.git", {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

" Plugin vim-shell
NeoBundle "https://github.com/Shougo/vimshell.vim.git"

" Plugin complete, to add auto completion
NeoBundle "https://github.com/Shougo/neocomplete.vim.git"
NeoBundle "https://github.com/Shougo/neosnippet.vim.git"

"------------------------------------------------------------------------------
" Plugin for file exproler
"------------------------------------------------------------------------------
NeoBundle 'https://github.com/Shougo/unite.vim'
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

" Plugin for buffer
" buftabs
NeoBundle 'https://github.com/vim-scripts/buftabs'

let g:buftabs_only_basename = 1
let g:buftabs_in_statusline = 1
let g:buftabs_active_highlight_group="Visual"

"------------------------------------------------------------------------------
" Plugin for programing
"------------------------------------------------------------------------------
"
" Plugin for git
NeoBundle 'https://github.com/tpope/vim-fugitive.git'
NeoBundle 'https://github.com/gregsexton/gitv.git'
autocmd FileType git :setlocal foldlevel=99

" vim-quickrun
NeoBundle 'https://github.com/thinca/vim-quickrun.git'
let g:quickrun_config = {
    \ "*": {"runner": "vimproc"},
    \ }

" vim-indent-guides
NeoBundle 'https://github.com/nathanaelkane/vim-indent-guides.git'
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=DarkRed ctermbg=darkgray
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  guibg=DarkGreen ctermbg=darkcyan
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1

" static analyzer
NeoBundle 'https://github.com/scrooloose/syntastic.git'

" python
"NeoBundle 'https://github.com/nvie/vim-flake8'
"NeoBundle 'https://github.com/alfredodeza/pytest.vim.git'

" Django
"NeoBundleLazy "lambdalisue/vim-django-support", {
"            \ "autoload": {
"            \   "filetypes": ["python", "python3", "djangohtml"]
"            \ }}
" virtualenv
"NeoBundleLazy "jmcantrell/vim-virtualenv", {
"            \ "autoload": {
"            \   "filetypes": ["python", "python3", "djangohtml"]
"            \ }}

"NeoBundleLazy "davidhalter/jedi-vim", {
"      \ "autoload": {
"      \   "filetypes": ["python", "python3", "djangohtml"],
"      \ },
"      \ "build": {
"      \   "mac": "pip install jedi",
"      \   "unix": "pip install jedi",
"      \ }}
"let s:hooks = neobundle#get_hooks("jedi-vim")
"function! s:hooks.on_source(bundle)
"    autocmd FileType python setlocal omnifunc=jedi#completions
"
"    let g:jedi#auto_vim_configuration = 1
"
"    if !exists('g:neocomplete#force_omni_input_patterns')
"        let g:neocomplete#force_omni_input_patterns = {}
"    endif
"
"    let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
"    let g:jedi#rename_command = '<Leader>R'
"    " gundoと被るため大文字に変更 (2013-06-24 10:00 追記）
"    let g:jedi#goto_command = '<Leader>G'
"endfunction

"------------------------------------------------------------------------------
" Plugin for write text docment
"------------------------------------------------------------------------------
" Genko pages counter
NeoBundle 'https://github.com/fuenor/JpFormat.vim.git'

" Plugin for evernote
NeoBundle 'https://github.com/kakkyz81/evervim.git'

" 1}}}
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

"------------------------------------------------------------------------------
" Display settings
"------------------------------------------------------------------------------
set wrap
set number
set title
set ruler

"------------------------------------------------------------------------------
" status line settings
"------------------------------------------------------------------------------
set statusline=%=\ [%{(&fenc!=''?&fenc:&enc)}/%{&ff}]\[%Y]\[%04l,%03v][%p%%]
set laststatus=2

"------------------------------------------------------------------------------
" Other
"------------------------------------------------------------------------------
set foldmethod=marker

"------------------------------------------------------------------------------
" Colorscheme
"------------------------------------------------------------------------------
NeoBundle 'https://github.com/altercation/vim-colors-solarized'
"syntax on
set t_Co=256
set background=dark
"colorscheme solarized
let g:solarized_termcolors=256
syntax enable
"let g:solarized_termtrans=1

" }}}
"==============================================================================
" Key mapping {{{
"------------------------------------------------------------------------------
" Key mapping for plugin
"------------------------------------------------------------------------------
" <Space>. : open .vimrc
nnoremap <Space>. :<C-u>tabedit $MYVIMRC<CR>

"------------------------------------------------------------------------------
" <Ctrl> + p : Using ctrlp
"------------------------------------------------------------------------------
let g:ctrlp_map = '<c-p>'

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

" }}}
"==============================================================================
function! DisplayCreator(mode)
    "{{{
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
function! TemplateReader(mode)
" {{{ 

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

