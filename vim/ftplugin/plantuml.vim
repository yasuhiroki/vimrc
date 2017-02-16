setlocal shiftwidth=2 softtabstop=2 tabstop=2

if (exists('g:loaded_plantuml_auto_compile') && g:loaded_plantuml_auto_compile)
    finish
endif

let g:loaded_plantuml_auto_compile = 1

function! g:PlantumlCompile(filename)
    execute 'silent !plantuml ' . a:filename . ' &'
endfunction

autocmd BufWritePost *.pu call g:PlantumlCompile(expand('%:p'))
