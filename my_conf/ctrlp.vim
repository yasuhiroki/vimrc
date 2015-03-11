" ctrlp.vim
NeoBundle 'https://github.com/kien/ctrlp.vim.git'
if neobundle#is_installed('ctrlp.vim')
    let g:ctrlp_use_migemo = 1
    let g:ctrlp_clear_cache_on_exit = 0   " Doesn't cache clear when vim quit
    let g:ctrlp_mruf_max            = 500 " Max memorable mru
    let g:ctrlp_open_new_file       = 1   " Open new file as tab
    let g:ctrlp_buffer_func = {
        \ 'enter': 'Ctrlp_laststatus_0',
        \ 'exit':  'Ctrlp_laststatus_2',
        \ }
    func! Ctrlp_laststatus_0()
        set laststatus=0
    endfunc
    func! Ctrlp_laststatus_2()
        set laststatus=2
    endfunc
endif
"------------------------------------------------------------------------------
" <Ctrl> + p : Using ctrlp
"------------------------------------------------------------------------------
let g:ctrlp_map = '<c-p>'

