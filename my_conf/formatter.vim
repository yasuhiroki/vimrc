" Intent Guide
" NeoBundle 'https://github.com/nathanaelkane/vim-indent-guides.git'
NeoBundle 'https://github.com/Yggdroot/indentLine'
let g:indentLine_faster = 1
nmap <silent><Leader>i :<C-u>IndentLinesToggle<CR>

" Remove tail whitespace
NeoBundle 'https://github.com/bronson/vim-trailing-whitespace'

" 80 column color
if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif

" Text align
NeoBundle 'h1mesuke/vim-alignta.git'
vnoremap <silent> => :Align @= =><CR>

NeoBundle 'junegunn/vim-easy-align.git'
