"==============================================================================
" FILE: vimrc
"==============================================================================
if has('python3')
  set pyxversion=3
endif

if has("mac")
  " lua is installed by homebrew
  set luadll=/usr/local/opt/lua@5.3/lib/liblua.dylib
end

if &compatible
  set nocompatible
endif

" Plugin Management {{{1
"  Using vim-plug to manage plugins.
"
let s:plugins_vim = expand('~/.vim/plugins.vim')
if filereadable(s:plugins_vim)
  execute 'source' s:plugins_vim
endif
"1}}}

filetype plugin indent on
syntax enable

"==============================================================================
" # Setting {{{1
"------------------------------------------------------------------------------
" ft_sql の補完機能は独特の設定なので使わない
let g:omni_sql_no_default_maps = 1
let $BASH_ENV='~/.vim/alias_for_vim.sh'
"# 1}}}

"==============================================================================
" # Color {{{1
"------------------------------------------------------------------------------
set t_Co=256
set background=dark
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
set incsearch
set showcmd

" preview は読まないので表示しない
set completeopt=menu

" gui vim の scrollbar は非表示
set guioptions=


"------------------------------------------------------------------------------
" status line settings
"------------------------------------------------------------------------------
set laststatus=2

"------------------------------------------------------------------------------
" Other
"------------------------------------------------------------------------------
set foldmethod=syntax
set foldlevel=100
set dictionary+=/usr/share/dict/words

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
nnoremap Q gq

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
" Key mapping in insert mode
"------------------------------------------------------------------------------
inoremap <C-f> <Right>
inoremap <C-b> <Left>

"------------------------------------------------------------------------------
" Save with sudo by :w!!
"   > http://lambdalisue.hatenablog.com/entry/2015/12/25/000046
"------------------------------------------------------------------------------
cabbr w!! w !sudo tee > /dev/null %

"------------------------------------------------------------------------------
" Use quickfix with grep
"------------------------------------------------------------------------------
autocmd QuickFixCmdPost *grep* cwindow


"------------------------------------------------------------------------------
" Enable :Man always
"   > http://rcmdnk.github.io/blog/2014/07/20/computer-vim/
"------------------------------------------------------------------------------
runtime ftplugin/man.vim
autocmd FileType man setlocal nospell ts=8 nolist ro nomod noma

"------------------------------------------------------------------------------
" Enable matchit.vim
"------------------------------------------------------------------------------
if !exists('loaded_matchit')
    runtime macros/matchit.vim
endif

" }}}
