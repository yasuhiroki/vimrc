" filetype sql を開くと omnifunc が sqlcomplete#Complete に設定されてしまうので、
" ale の completion を使うよう上書きしている
" sqlcomplete prefix なので sqlcomplete.vim で実装しないと動かない
function! sqlcomplete#Complete(findstart, base)
    return ale#completion#OmniFunc(a:findstart, a:base)
endfunc
