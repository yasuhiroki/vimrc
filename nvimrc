"==============================================================================
" FILE: nvimrc(init.vim)
"==============================================================================
" Plugin Management {{{1
"  Using dein to magnage plugins.
"
let s:dein_dir = expand('~/.config/nvim/dein')
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

  let s:toml           = s:dein_dir . '/dein.toml'
  let s:lazy_toml      = s:dein_dir . '/dein_lazy.toml'
  let s:nvim_toml      = s:dein_dir . '/nvim_dein.toml'
  let s:nvim_lazy_toml = s:dein_dir . '/nvim_dein_lazy.toml'
  let s:_toml          = s:dein_dir . '/local_dein.toml'
  let s:_lazy_toml     = s:dein_dir . '/local_dein_lazy.toml'

  call dein#load_toml(s:toml,           {'lazy': 0})
  call dein#load_toml(s:lazy_toml,      {'lazy': 1})
  call dein#load_toml(s:nvim_toml,      {'lazy': 0})
  call dein#load_toml(s:nvim_lazy_toml, {'lazy': 1})
  call dein#load_toml(s:_toml,          {'lazy': 0})
  call dein#load_toml(s:_lazy_toml,     {'lazy': 1})

  if dein#check_install()
    call dein#install()
  endif

  call dein#end()
  call dein#save_state()
endif

"2}}}
"1}}}

if has("mac")
  " lua is installed by homebrew
  " set luadll=/usr/local/Cellar/lua/5.2.4_4/lib/liblua.dylib
end

filetype plugin indent on
syntax enable

"==============================================================================
" # Color {{{1
"------------------------------------------------------------------------------
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized

if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif


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

"------------------------------------------------------------------------------
" status line settings
"------------------------------------------------------------------------------
set laststatus=2

"------------------------------------------------------------------------------
" Other
"------------------------------------------------------------------------------
set foldmethod=marker

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
