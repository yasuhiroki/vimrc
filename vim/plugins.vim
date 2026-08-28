"==============================================================================
" FILE: plugins.vim
" DESCRIPTION: Plugin definitions and configurations using vim-plug
"==============================================================================

" Auto install vim-plug if not installed
let s:plug_file = expand('~/.vim/autoload/plug.vim')
if empty(glob(s:plug_file))
  echo 'Installing vim-plug...'
  silent execute '!curl -fLo ' . s:plug_file . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  execute 'source ' . fnameescape(s:plug_file)
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if !exists('*plug#begin') && filereadable(s:plug_file)
  execute 'source ' . fnameescape(s:plug_file)
endif

call plug#begin('~/.vim/plugged')

" Theme
Plug 'altercation/vim-colors-solarized'

" Lint & LSP & Snippets
Plug 'dense-analysis/ale'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'

" Git
Plug 'vim-denops/denops.vim'
Plug 'lambdalisue/gin.vim'
Plug 'cohama/agit.vim', { 'on': 'Agit' }

" Terminal
Plug 'yasuhiroki/wezterm.vim'

" Tools & Navigation & Coding
Plug 'thinca/vim-quickrun', { 'on': 'QuickRun' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rking/ag.vim'
Plug 'junegunn/vim-easy-align'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-surround'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'thinca/vim-ref'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'lambdalisue/fern.vim'

" View & Syntax
Plug 'b4b4r07/buftabs'
Plug 'rhysd/vim-gfm-syntax'
Plug 'vim-scripts/AnsiEsc.vim'

" Filetype & Language plugins
Plug 'yasuhiroki/zshef.vim'
Plug 'yasuhiroki/zoho-deluge.vim'
Plug 'vim-scripts/groovyindent-unix'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'ekalinin/Dockerfile.vim'
Plug 'yasuhiroki/circleci.vim'
Plug 'yasuhiroki/github-actions-yaml.vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'posva/vim-vue'
Plug 'udalov/kotlin-vim'
Plug 'tpope/vim-markdown'
Plug 'jparise/vim-graphql'
Plug 'terrastruct/d2-vim'

" Lazy-loaded filetype plugins
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'mattn/emmet-vim', { 'for': ['html', 'xml', 'markdown'] }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'scss', 'sass'] }
Plug 'othree/yajs.vim', { 'for': ['javascript', 'typescript'] }
Plug 'jason0x43/vim-js-indent', { 'for': ['javascript', 'typescript', 'html'] }
Plug 'leafgarland/typescript-vim', { 'for': ['typescript', 'typescriptreact'] }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
Plug 'mattn/vim-goimports', { 'for': 'go' }
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }
Plug 'aklt/plantuml-syntax', { 'for': 'plantuml' }
Plug 'yasuhiroki/vim-plantuml-snippets', { 'for': 'plantuml' }
Plug 'yasuhiroki/vim-aws-plantuml-snippets', { 'for': 'plantuml' }

" Local plugins (if any)
if filereadable(expand('~/.vim/local_plugins.vim'))
  source ~/.vim/local_plugins.vim
endif

call plug#end()


"==============================================================================
" Plugin Configurations
"==============================================================================

"------------------------------------------------------------------------------
" ALE
"------------------------------------------------------------------------------
let g:ale_disable_lsp = 1
let g:ale_virtualtext_cursor = 0
let g:ale_floating_preview = 1
let g:ale_linter_aliases = {}
let g:ale_linters_explicit = 1
let g:ale_linters = {
\   'python': ['pylint'],
\   'go': ['govet', 'staticcheck'],
\}
let g:ale_fixers = {
\   'javascript': ['prettier-eslint'],
\   'json': ['prettier'],
\   'css': ['prettier'],
\   'scss': ['prettier'],
\   'ruby': ['rubocop'],
\}

let g:ale_pattern_options = {
\ '\..*\.js$': {'ale_linters': [], 'ale_fixers': []},
\ '\..*\.css$': {'ale_linters': [], 'ale_fixers': []},
\}
let g:ale_pattern_options_enabled = 1

nmap <silent> K <Plug>(ale_detail)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)

"------------------------------------------------------------------------------
" vim-lsp & vim-lsp-settings
"------------------------------------------------------------------------------
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> <C-]> <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> K <plug>(lsp-hover)
    nmap <buffer> ]c :LspNextDiagnostic<CR>
    nmap <buffer> [c :LspPreviousDiagnostic<CR>
    let g:lsp_format_sync_timeout = 1000
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_virtual_text_enabled = 0

" for debugging
" let g:lsp_log_file = './lsp.log'

let g:lsp_settings = {
\   'yaml-language-server': {
\       'allowlist': ['yaml', 'yaml.circleci', 'yaml.gha'],
\       'workspace_config': {
\           'yaml': {
\               'schemas': {
\                   'https://json.schemastore.org/circleciconfig.json': ['.circleci/config.yml'],
\                   'https://json.schemastore.org/github-action.json': ['.github/actions/*.yml']
\               }
\           }
\      }
\   },
\   'typeprof': {'disabled': 1}
\}

function! s:lsp_setup_ruby() abort
    if !exists('s:rubocop_registered')
        let s:rubocop_registered = 1
        let l:cmd = ['rubocop', '--lsp']
        if filereadable('Gemfile') && executable('bundle')
            let l:cmd = ['bundle', 'exec', 'rubocop', '--lsp']
        endif

        call lsp#register_server({
        \   'name': 'rubocop',
        \   'cmd': {server_info-> l:cmd},
        \   'allowlist': ['ruby']
        \ })
    endif
endfunction

augroup ft_ruby_config
    autocmd!
    autocmd FileType ruby call s:lsp_setup_ruby()
augroup END

"------------------------------------------------------------------------------
" vsnip
"------------------------------------------------------------------------------
imap <expr> <C-j> vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)' : '<C-j>'
smap <expr> <C-j> vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)' : '<C-j>'
imap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
smap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<C-k>'

nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)

let g:vsnip_filetypes = {}

"------------------------------------------------------------------------------
" denops & gin.vim
"------------------------------------------------------------------------------
let g:denops_disable_version_check = 1

function! OpenGinTab(ginCommand)
    let searchName = '^' . tolower(a:ginCommand)
    let tabCount = tabpagenr('$')
    for tabnum in range(1, tabCount)
        for winnr in range(1, tabpagewinnr(tabnum, '$'))
            let bufnr = tabpagebuflist(tabnum)[winnr - 1]
            let name = bufname(bufnr)
            if match(name, searchName) != -1
                execute 'tabn ' . tabnum
                execute winnr . 'wincmd w'
                return
            endif
        endfor
    endfor
    execute 'tabnew'
    execute a:ginCommand
endfunction

let g:gin_log_default_args = ['--graph', '--decorate']
autocmd FileType gin-log nnoremap <buffer> <nowait> o :GinBrowse --commit <CR>
autocmd FileType gin-log nnoremap <buffer> <nowait> f <Plug>(gin-action-fixup)

nmap <Leader>gs :call OpenGinTab('GinStatus')<CR>
nmap <Leader>gc :Gin commit<CR>
nmap <Leader>gl :call OpenGinTab('GinLog')<CR>
nmap <Leader>gg :Ag 
nmap <Leader>gb :GinBlame %:p<CR>
function! s:gin_browse() abort
    let l:cword = expand('<cword>')
    if l:cword =~# '^[0-9a-fA-F]\{7,64\}$'
        return ":\<C-u>GinBrowse --commit " .. l:cword .. "\<CR>"
    endif
    return "\<Plug>(gin-action-browse)"
endfunction

xnoremap <Leader>go y:<C-u>execute 'GinBrowse --commit ' .. trim(@")<CR>
nmap <expr> <Leader>go <SID>gin_browse()

"------------------------------------------------------------------------------
" agit.vim
"------------------------------------------------------------------------------
nmap <Leader>ga :Agit<CR>

function! s:agit_gin_browse() abort
    let l:hash = agit#extract_hash(getline('.'))
    if !empty(l:hash)
        execute 'GinBrowse --commit ' .. l:hash
    endif
endfunction

autocmd FileType agit,agit_stat,agit_diff nnoremap <buffer> <nowait> <silent> go :<C-u>call <SID>agit_gin_browse()<CR>

"------------------------------------------------------------------------------
" Quickrun
"------------------------------------------------------------------------------
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
nnoremap <leader>r :QuickRun<CR>

"------------------------------------------------------------------------------
" CtrlP & ag
"------------------------------------------------------------------------------
let g:ctrlp_use_migemo = 1 " Don't install migemo yet
let g:ctrlp_clear_cache_on_exit = 0   " Doesn't cache clear when vim quit
let g:ctrlp_mruf_max            = 500 " Max memorable mru
let g:ctrlp_open_new_file       = 1   " Open new file as tab

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

if executable('ag')
    let g:ctrlp_use_caching = 0
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup -g ""'
endif

"------------------------------------------------------------------------------
" EasyAlign
"------------------------------------------------------------------------------
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"------------------------------------------------------------------------------
" Indent Guides
"------------------------------------------------------------------------------
let g:indent_guides_enable_on_vim_startup = 1

"------------------------------------------------------------------------------
" Buftabs
"------------------------------------------------------------------------------
let g:buftabs_only_basename = 1
let g:buftabs_in_statusline = 1
let g:buftabs_active_highlight_group = "Visual"

"------------------------------------------------------------------------------
" Fern (Filer)
"------------------------------------------------------------------------------
nmap <Leader>f :Fern . -reveal=% -drawer -toggle<CR>
command! Tree Fern . -reveal=% -drawer -toggle
let g:fern#disable_default_mappings          = 1
let g:fern#disable_viewer_spinner            = 1
let g:fern#mark_symbol                       = ''
let g:fern#renderer#default#collapsed_symbol = '▷ '
let g:fern#renderer#default#expanded_symbol  = '▼ '
let g:fern#renderer#default#leading          = ' '
let g:fern#renderer#default#leaf_symbol      = '| '
let g:fern#renderer#default#root_symbol      = '~ '

function! s:init_fern() abort
  setlocal nonumber
  setlocal signcolumn=no

  nmap <buffer> yy <Plug>(fern-action-yank:label)
  nmap <buffer>  Y <Plug>(fern-action-yank:path)

  " Define NERDTree like mappings
  nmap <buffer><expr>
    \ <Plug>(fern-action-open-or-expand-or-collapse)
    \ fern#smart#leaf(
    \   "<Plug>(fern-action-open)",
    \   "<Plug>(fern-action-expand:stay)",
    \   "<Plug>(fern-action-collapse)",
    \ )
  nmap <buffer> <CR> <Plug>(fern-action-open-or-expand-or-collapse)
  nmap <buffer> x <Plug>(fern-action-focus:parent)<Plug>(fern-action-collapse)
  nmap <buffer> o <Plug>(fern-action-open:edit)
  nmap <buffer> go <Plug>(fern-action-open:edit)<C-w>p
  nmap <buffer> t <Plug>(fern-action-open:tabedit)
  nmap <buffer> T <Plug>(fern-action-open:tabedit)gT
  nmap <buffer> i <Plug>(fern-action-open:split)
  nmap <buffer> gi <Plug>(fern-action-open:split)<C-w>p
  nmap <buffer> s <Plug>(fern-action-open:vsplit)
  nmap <buffer> gs <Plug>(fern-action-open:vsplit)<C-w>p

  nmap <buffer> ma <Plug>(fern-action-new-path)
  nmap <buffer> mc <Plug>(fern-action-copy)
  nmap <buffer> md <Plug>(fern-action-remove)
  nmap <buffer> mm <Plug>(fern-action-move)

  nmap <buffer> C <Plug>(fern-action-enter)
  nmap <buffer> u <Plug>(fern-action-leave)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> R gg<Plug>(fern-action-reload)<C-o>

  nmap <buffer> I <Plug>(fern-action-hidden:toggle)

  nmap <buffer> q :<C-u>quit<CR>
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

"------------------------------------------------------------------------------
" GFM Syntax
"------------------------------------------------------------------------------
let g:gfm_syntax_emoji_conceal = 1

"------------------------------------------------------------------------------
" CircleCI & GitHub Actions
"------------------------------------------------------------------------------
let g:circleci_omnifunc_enable = 0
let g:gha_completion = 0

"------------------------------------------------------------------------------
" Markdown
"------------------------------------------------------------------------------
let g:markdown_syntax_conceal = 0
let g:markdown_recommended_style = 0
let g:markdown_fenced_languages = [
\   'ruby',
\   'sh=bash',
\   'json',
\   'yaml',
\]

"------------------------------------------------------------------------------
" Ruby
"------------------------------------------------------------------------------
let g:ruby_indent_access_modifier_style = 'indent'
let g:ruby_indent_block_style = 'do'

"------------------------------------------------------------------------------
" JavaScript / TypeScript
"------------------------------------------------------------------------------
let g:js_indent_typescript = 1


