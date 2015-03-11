"------------------------------------------------------------------------------
NeoBundle 'https://github.com/Shougo/unite.vim'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200

nnoremap [unite]    <Nop>
nmap     <Space><Space> [unite]
nnoremap [unite]u   :<C-u>Unite<Space>
nnoremap <silent> [unite]c   :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]b   :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]f   :<C-u>Unite file<CR>

"------------------------------------------------------------------------------
NeoBundle 'https://github.com/ujihisa/unite-colorscheme'

