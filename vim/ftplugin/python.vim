"-------------------------------------------------------------------------------
" Key mapping for Python file
"-------------------------------------------------------------------------------

"--------------------------------------
" Pytest.vim plugin
"--------------------------------------
if neobundle#is_installed('pytest.vim')
    nmap <silent><Leader>f <Esc>:Pytest file<CR>
    nmap <silent><Leader>c <Esc>:Pytest class<CR>
    nmap <silent><Leader>m <Esc>:Pytest method<CR>
endif
