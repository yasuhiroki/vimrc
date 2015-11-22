NeoBundleLazy 'https://github.com/marcus/rsense', {
            \ 'autoload': {
            \   'filetypes': 'ruby',
            \ },
            \ }
NeoBundle 'https://github.com/supermomonga/neocomplete-rsense.vim', {
            \ 'depends': ['Shougo/neocomplete.vim', 'marcus/rsense'],
            \ }
let g:rsenseUseOmniFunc = 1
let g:neocomplete#sources#omni#input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

NeoBundle 'thinca/vim-ref'
NeoBundle 'yuku-t/vim-ref-ri'
let g:ref_refe_cmd = $HOME.'/.rbenv/shims/refe'
