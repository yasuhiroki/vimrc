"==============================================================================
" FILE: vimrc
"==============================================================================
" Plugin Management
"  Using NeoBundle to magnage plugins.
"------------------------------------------------------------------------------
" # NeoBundle {{{1
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
"==============================================================================
" # Plugins {{{1
"------------------------------------------------------------------------------
call neobundle#begin()

" Read some my conf
runtime! my_conf/*.vim

"------------------------------------------------------------------------------
" ## Happy Programming {{{2
"------------------------------------------------------------------------------
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" ### Common {{{3
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" #### vim-quickrun {{{4
NeoBundle 'https://github.com/thinca/vim-quickrun.git'
let g:quickrun_config = {
            \ "_": {"runner": "vimproc"},
            \ }
" Stop quickrun by <C-c>
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

NeoBundle "https://github.com/Shougo/vimproc.vim.git", {
            \ 'build' : {
            \     'windows' : 'make -f make_mingw32.mak',
            \     'mac' : 'make -f make_mac.mak',
            \     'unix' : 'make -f make_unix.mak',
            \    },
            \ }

"4}}}
" #### Shougo/neocomplete {{{4
" Mac OS X setting
if has("mac")
  " lua is installed by homebrew
  set luadll=/usr/local/Cellar/lua/5.2.4_1/lib/liblua.dylib
end
NeoBundle "https://github.com/Shougo/neocomplete.vim.git"
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1

" Define dictionary.
let g:neocomplete_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete_keyword_patterns')
    let g:neocomplete_keyword_patterns = {}
endif
let g:neocomplete_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return neocomplete#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

"4}}}
" #### Buffer {{{4
NeoBundle 'https://github.com/vim-scripts/buftabs'
let g:buftabs_only_basename = 1
let g:buftabs_in_statusline = 1
let g:buftabs_active_highlight_group="Visual"
"}}}

" static analyzer
NeoBundle 'https://github.com/scrooloose/syntastic.git'

NeoBundle 'tpope/vim-surround'

"3}}}
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" ### Git {{{3
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" Support git commit
NeoBundle 'https://github.com/tpope/vim-fugitive.git'
" Show git log graph
NeoBundle 'https://github.com/cohama/agit.vim.git'
" Management branch
NeoBundle 'idanarye/vim-merginal'

"3}}}
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" ### Ruby & Rails {{{3
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
NeoBundle 'https://github.com/tpope/vim-endwise'
NeoBundle 'https://github.com/tpope/vim-rails'

NeoBundleLazy 'https://github.com/marcus/rsense', {
            \ 'autoload': {
            \   'filetypes': 'ruby',
            \ },
            \ }
NeoBundle 'https://github.com/supermomonga/neocomplete-rsense.vim', {
            \ 'depends': ['Shougo/neocomplete.vim', 'marcus/rsense'],
            \ }
let g:rsenseUseOmniFunc = 1
let g:neocomplete#sources#omni#input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

NeoBundle 'thinca/vim-ref'
NeoBundle 'yuku-t/vim-ref-ri'
let g:ref_refe_cmd = $HOME.'/.rbenv/shims/refe'

"}}}
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" ### Ruby & Rails {{{3
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
"3}}}
"2}}}
"------------------------------------------------------------------------------
" ## Appearance {{{2
"------------------------------------------------------------------------------
NeoBundle 'https://github.com/altercation/vim-colors-solarized'

NeoBundle 'https://github.com/scrooloose/nerdtree.git'
"NeoBundle 'justinmk/vim-dirvish'
"let g:dirvish_hijack_netrw = 1

" ### CTRL-P {{{3
NeoBundle 'nixprime/cpsm', {
            \ 'build' : {
            \   'others': 'sh install.sh',
            \ },
            \ }

NeoBundle 'ctrlpvim/ctrlp.vim'
if neobundle#is_installed('ctrlp.vim')
    "let g:ctrlp_use_migemo = 1 Don't install migemo yet
    let g:ctrlp_clear_cache_on_exit = 0   " Doesn't cache clear when vim quit
    let g:ctrlp_mruf_max            = 500 " Max memorable mru
    let g:ctrlp_open_new_file       = 1   " Open new file as tab
    let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}

    set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

    let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)$',
      \ 'file': '\v\.(exe|so|dll)$',
      \ }
endif
" 3}}}

"2}}}
"------------------------------------------------------------------------------
" ## Nobel {{{2
"------------------------------------------------------------------------------
" Genko pages counter
NeoBundle 'https://github.com/fuenor/JpFormat.vim.git'
noremap <Leader>g :JpCountPages 20 20 <Return>

call neobundle#end()

"2}}}
"1}}}
"==============================================================================
" # Color {{{1
"------------------------------------------------------------------------------
syntax enable
set t_Co=256
if has('mac')
    set background=light
else
    set background=dark
endif
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized

"}}}
"==============================================================================
" # Options {{{1
"------------------------------------------------------------------------------
set encoding=utf8
set scrolloff=5
set backup
set swapfile
set backupdir=~/.vim/backup
set directory=~/.vim/swap

set shiftwidth=4
set tabstop=4
set smarttab
set expandtab
set autoindent
set textwidth=0

"------------------------------------------------------------------------------
" Display settings
"------------------------------------------------------------------------------
set wrap
set number
set title
set ruler
set hlsearch
set showcmd

"------------------------------------------------------------------------------
" status line settings
"------------------------------------------------------------------------------
set statusline=%=\ %{fugitive#statusline()}[%{(&fenc!=''?&fenc:&enc)}/%{&ff}]\[%Y]\[%04l,%03v][%p%%]
set laststatus=2

"------------------------------------------------------------------------------
" Other
"------------------------------------------------------------------------------
set foldmethod=marker
filetype plugin indent on
filetype on

"------------------------------------------------------------------------------
" Only MacVim
"------------------------------------------------------------------------------
if has('mac')
    set imdisable
endif

" }}}
"==============================================================================
" # Key mapping {{{1
"------------------------------------------------------------------------------
"------------------------------------------------------------------------------
" Key mapping for buffer
"------------------------------------------------------------------------------
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"------------------------------------------------------------------------------
" Key mapping for virtual area yunk
"------------------------------------------------------------------------------
vnoremap * "zy:let @/ = @z<CR>n

"------------------------------------------------------------------------------
" Enable to read *.md file as markdown
"------------------------------------------------------------------------------
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown

"------------------------------------------------------------------------------
" Key mapping in command line
"------------------------------------------------------------------------------
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <C-b>
cnoremap <C-e> <C-e>
cnoremap <C-u> <C-e><C-u>
cnoremap <C-v> <C-f>a

" }}}
"==============================================================================
function! DisplayCreator(mode) "{{{1
    "------------------------------------------------------------------------------
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
        :Agit
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
