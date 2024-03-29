" http://komachi.yomiuri.co.jp/t/2013/0911/617138.htm
let s:save_cpo = &cpo
set cpo&vim

if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= ' | '
else
    let b:undo_ftplugin = ''
endif
let b:undo_ftplugin .= 'setl modeline<'

" set indent.
setlocal shiftwidth=2 softtabstop=2 tabstop=2

" foldmethod=syntax is slow insert mode in large ruby file
setlocal foldmethod=manual

let &cpo = s:save_cpo
