" filetype sql を開くと omnifunc が sqlcomplete#Complete に設定されてしまうので、
" ale の completion を使うよう上書きしている

" ここで実行しないと、本 sql.vim を読み込んだ後に autoload/sqlcomplete.vim が読み込まれて
" sqlcomplete#Complete が元の実装に戻ってしまう
runtime autoload/sqlcomplete.vim

source ~/.vim/ftplugin/sqlcomplete.vim
