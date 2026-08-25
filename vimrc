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

" Plugin Management {{{1
"  Using dpp.vim to manage plugins.
"
let s:dpp_base = expand('~/.cache/dpp')
let s:dpp_config = expand('~/.vim/dpp/dpp.ts')

" Required plugins to bootstrap dpp.vim
let s:dpp_repos = [
\   'Shougo/dpp.vim',
\   'vim-denops/denops.vim',
\   'Shougo/dpp-ext-installer',
\   'Shougo/dpp-ext-toml',
\   'Shougo/dpp-ext-lazy',
\   'Shougo/dpp-protocol-git',
\]

" Ensure runtimepath and clone if not present
for s:repo in s:dpp_repos
  let s:dir = s:dpp_base . '/repos/github.com/' . s:repo
  if !isdirectory(s:dir)
    execute '!git clone https://github.com/' . s:repo s:dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dir, ':p')
endfor

if &compatible
  set nocompatible
endif

if dpp#min#load_state(s:dpp_base)
  autocmd User DenopsReady
  \ : echohl WarningMsg
  \ | echomsg 'dpp load_state failed: regenerating state...'
  \ | echohl None
  \ | call dpp#make_state(s:dpp_base, s:dpp_config)
endif

" User commands for plugin management
command! DppInstall   call dpp#async_ext_action('installer', 'install')
command! DppUpdate    call dpp#async_ext_action('installer', 'update')
command! DppMakeState call dpp#make_state(s:dpp_base, s:dpp_config)

"2}}}
"1}}}

filetype plugin indent on
syntax enable

"==============================================================================
" # Setting {{{1
"------------------------------------------------------------------------------
" vim-ruby の最新版が必要なら dpp で入れる
let g:ruby_indent_access_modifier_style = 'indent'
let g:ruby_indent_block_style = 'do'
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
