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
NeoBundle 'thinca/vim-quickrun'
let g:quickrun_config = {
            \ "_": {"runner": "vimproc"},
            \ }
" Stop quickrun by <C-c>
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

NeoBundle "Shougo/vimproc.vim", {
            \ 'build' : {
            \     'windows' : 'make -f make_mingw32.mak',
            \     'mac' : 'make -f make_mac.mak',
            \     'unix' : 'make -f make_unix.mak',
            \    },
            \ }

"4}}}
" #### Shougoware {{{4
" Mac OS X setting
if has("mac")
  " lua is installed by homebrew
  set luadll=/usr/local/Cellar/lua/5.2.4_1/lib/liblua.dylib
end
NeoBundle "Shougo/neocomplete.vim"
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

NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
 \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

NeoBundle 'honza/vim-snippets'
let g:snips_author = "yasuhiroki"
let g:snips_email = "yasuhiroki.duck@gmail.com"
let g:snips_github = "https://github.com/yasuhiroki"

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

" ##### Unite {{{5
NeoBundle 'Shougo/unite.vim'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200

let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

nnoremap [unite]    <Nop>
nmap     <Space><Space> [unite]
nnoremap [unite]u   :<C-u>Unite<Space>
nnoremap <silent> [unite]c   :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]b   :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]f   :<C-u>Unite file<CR>
nnoremap <silent> [unite]g   :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" Refferenced: http://blog.monochromegane.com/blog/2013/09/18/ag-and-unite/
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif
"5}}}

"4}}}
" #### Buffer {{{4
NeoBundle 'vim-scripts/buftabs'
let g:buftabs_only_basename = 1
let g:buftabs_in_statusline = 1
let g:buftabs_active_highlight_group="Visual"
"}}}

" static analyzer
NeoBundle 'scrooloose/syntastic'

NeoBundle 'tpope/vim-surround'

"3}}}
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" ###  {{{3
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

"3}}}
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" ### Format {{{3
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
NeoBundle 'junegunn/vim-easy-align.git'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

NeoBundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup=1

"3}}}
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" ### Git {{{3
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" Support commit; :Gstatus, :Gdiff, :Gblame
NeoBundle 'tpope/vim-fugitive'
" Show log graph; :Agit
NeoBundle 'cohama/agit.vim'
" Management branch; :Merginal
NeoBundle 'idanarye/vim-merginal'

"3}}}
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" ### Ruby & Rails {{{3
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-rails'

NeoBundleLazy 'marcus/rsense', {
            \ 'autoload': {
            \   'filetypes': 'ruby',
            \ },
            \ }
NeoBundle 'supermomonga/neocomplete-rsense.vim', {
            \ 'depends': ['Shougo/neocomplete.vim', 'marcus/rsense'],
            \ }
let g:rsenseUseOmniFunc = 1
let g:neocomplete#sources#omni#input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby', 'javascript'] }
let g:syntastic_ruby_checkers = ['rubocop']

NeoBundle 'thinca/vim-ref'
NeoBundle 'yuku-t/vim-ref-ri'
let g:ref_refe_cmd = $HOME.'/.rbenv/shims/refe'

"}}}
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" ### JavaScript & Node.js {{{3
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
NeoBundleLazy 'heavenshell/vim-jsdoc' ,{
            \    "autoload" : {"filetypes" : ["javascript"]}
            \}

NeoBundle "kchmck/vim-coffee-script"
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
" インデント設定
autocmd FileType coffee    setlocal sw=2 sts=2 ts=2 et
" オートコンパイル
  "保存と同時にコンパイルする
"autocmd BufWritePost *.coffee silent make!
  "エラーがあったら別ウィンドウで表示
autocmd QuickFixCmdPost * nested cwindow | redraw!
" Ctrl-cで右ウィンドウにコンパイル結果を一時表示する
nnoremap <silent> <C-C> :CoffeeCompile vert <CR><C-w>h

"3}}}
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" ### HTML {{{3
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
NeoBundle 'mattn/emmet-vim/'
NeoBundle "hail2u/vim-css3-syntax"
NeoBundle "pangloss/vim-javascript"
NeoBundle "othree/html5.vim"


"3}}}
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" ### Go {{{3
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
NeoBundle 'vim-jp/vim-go-extra'

"3}}}
"2}}}
"------------------------------------------------------------------------------
" ## Appearance {{{2
"------------------------------------------------------------------------------
NeoBundle 'altercation/vim-colors-solarized'

NeoBundle 'scrooloose/nerdtree'
"NeoBundle 'justinmk/vim-dirvish'
"let g:dirvish_hijack_netrw = 1

" Remove tail whitespace
NeoBundle 'bronson/vim-trailing-whitespace'

" 80 column color
if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif

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
NeoBundle 'fuenor/JpFormat.vim'
noremap <Leader>g :JpCountPages 20 20 <Return>

call neobundle#end()

"2}}}
"1}}}

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

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

"------------------------------------------------------------------------------
" Window size change shortcut
"   > http://lambdalisue.hatenablog.com/entry/2015/12/25/000046
"------------------------------------------------------------------------------
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

"------------------------------------------------------------------------------
" Save with sudo by :w!!
"   > http://lambdalisue.hatenablog.com/entry/2015/12/25/000046
"------------------------------------------------------------------------------
cabbr w!! w !sudo tee > /dev/null %


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
        :
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
