NeoBundle 'https://github.com/mattn/sonictemplate-vim.git'

"==============================================================================
function! TemplateReader(mode) " {{{ 

    if a:mode == "bash"
        :0r ~/.vim/template/bash.tmp
    endif

endfunction

function! ListTemplateReader(argv, cmd, cur)
    return "
        \bash\n
        \"
endfunction

command! -nargs=1 -complete=custom,ListTemplateReader -bar TemplateReader :call TemplateReader(<q-args>)
" }}}
"==============================================================================

