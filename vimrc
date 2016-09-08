"==============================================================================
" FILE: vimrc
"==============================================================================
" Plugin Management {{{1
"  Using dein to magnage plugins.
"
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" Install dein
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  " Add dein.vim to head of runtimepath
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
if &compatible
  set nocompatible
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml      = s:dein_dir . '/dein.toml'
  let s:lazy_toml = s:dein_dir . '/dein_lazy.toml'
  let s:_toml      = s:dein_dir . '/local_dein.toml'
  let s:_lazy_toml = s:dein_dir . '/local_dein_lazy.toml'

  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#load_toml(s:_toml,      {'lazy': 0})
  call dein#load_toml(s:_lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

call dein#begin(s:dein_dir)

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"------------------------------------------------------------------------------
" ## Happy Programming {{{2
"------------------------------------------------------------------------------
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" ### Common {{{3
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

" #### Shougoware {{{4
" Mac OS X setting
if has("mac")
  " lua is installed by homebrew
  set luadll=/usr/local/Cellar/lua/5.2.4_1/lib/liblua.dylib
end

call dein#add("Shougo/neocomplete.vim")
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

" ##### snippets {{{5
let g:neosnippet#snippets_directory = []
let g:neosnippet#snippets_directory += ['~/.vim/bundle/vim-plantuml-snippets/snippets']
let g:neosnippet#snippets_directory += ['~/.vim/bundle/neosnippet-snippets/neosnippets']


"4}}}
" #### Buffer {{{4
call dein#add('vim-scripts/buftabs')
let g:buftabs_only_basename = 1
let g:buftabs_in_statusline = 1
let g:buftabs_active_highlight_group="Visual"
"}}}

" Fast grep
call dein#add('rking/ag.vim')
if executable('ag')
    let g:ctrlp_use_caching = 0
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup -g ""'
endif

" static analyzer
call dein#add('scrooloose/syntastic')

" additional movement
call dein#add('tpope/vim-surround')

"3}}}
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" ### {{{3 UML Tool
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

call dein#add( "aklt/plantuml-syntax")


"3}}}
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" ### Format {{{3
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
call dein#add('junegunn/vim-easy-align.git')
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

call dein#add('nathanaelkane/vim-indent-guides')
let g:indent_guides_enable_on_vim_startup=1

"3}}}
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" ### Git {{{3
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

"3}}}
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" ### Ruby & Rails {{{3
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
call dein#add('tpope/vim-endwise')
call dein#add('tpope/vim-rails')

call dein#add('marcus/rsense', { 'lazy': 1, 'on_ft': ['ruby'] })
call dein#add('supermomonga/neocomplete-rsense.vim')
let g:rsenseUseOmniFunc = 1
let g:neocomplete#sources#omni#input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby', 'javascript'] }
let g:syntastic_ruby_checkers = ['rubocop']

call dein#add('thinca/vim-ref')
call dein#add('yuku-t/vim-ref-ri')
let g:ref_refe_cmd = $HOME.'/.rbenv/shims/refe'

"}}}
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" ### JavaScript & Node.js {{{3
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
call dein#add('heavenshell/vim-jsdoc' ,{ 'lazy': 1, 'on_ft': ['javascript'] })
call dein#add('pangloss/vim-javascript')

"3}}}
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" ### HTML {{{3
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


"3}}}
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
" ### Go {{{3
"- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
call dein#add('vim-jp/vim-go-extra')

"3}}}
"2}}}
"------------------------------------------------------------------------------
" ## Appearance {{{2
"------------------------------------------------------------------------------
call dein#add('altercation/vim-colors-solarized', {'merged': 0})

call dein#add('scrooloose/nerdtree')
"call dein#add('justinmk/vim-dirvish')
"let g:dirvish_hijack_netrw = 1

" Remove tail whitespace
call dein#add('bronson/vim-trailing-whitespace')

" 80 column color
if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif

" ### CTRL-P {{{3
call dein#add('nixprime/cpsm' )
call dein#add('ctrlpvim/ctrlp.vim' )
let g:ctrlp_use_migemo = 1 " Don't install migemo yet
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
" 3}}}

"2}}}
"------------------------------------------------------------------------------
" ## Nobel {{{2
"------------------------------------------------------------------------------
" Genko pages counter
call dein#add('fuenor/JpFormat.vim' )
noremap <Leader>g :JpCountPages 20 20 <Return>

call dein#end()

filetype plugin indent on

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

"------------------------------------------------------------------------------
" Enable :Man always
"   > http://rcmdnk.github.io/blog/2014/07/20/computer-vim/
"------------------------------------------------------------------------------
runtime ftplugin/man.vim
autocmd FileType man setlocal nospell ts=8 nolist ro nomod noma

" }}}
