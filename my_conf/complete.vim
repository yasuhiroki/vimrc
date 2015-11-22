" Plugin complete, to add auto completion
NeoBundle "https://github.com/Shougo/neocomplete.vim.git"
"NeoBundle "https://github.com/Shougo/neosnippet.vim.git"
"NeoBundle "https://github.com/Shougo/neosnippet-snippets"

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1

" Mac OS X setting
if has("mac")
  " lua is installed by homebrew
  set luadll=/usr/local/Cellar/lua/5.2.4_1/lib/liblua.dylib
end


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
