# Start-up for vim settings
if [ ! -f 'vimrc' ] \
    && [ ! -d 'ftplugin' ] \
    && [ ! -f 'startup.sh' ]; then

    echo "Plase execute in vimrc directory that you ran git clone."
    exit 1
fi

PRGDIR=`dirname $0`
echo "This is startup tool."
echo "Execution in $PRGDIR."

# git clone NeoBundle on ~/.vim/bundle
cd ~
if [ ! -d '~/.vim/bundle' ]; then
    echo "Create directory at HOME."
    mkdir -p ~/.vim/bundle
fi

if [ ! -d 'neobundle.vim' ]; then
    echo "Get neobundle.vim."
    pushd ~/.vim/bundle
    git clone git://github.com/Shougo/neobundle.vim.git
    popd
fi

if [ ! -f '~/.vimrc' ]; then
    echo "Copy .vimrc file."
    cp vimrc ~/.vimrc
fi

if [ !-d '~/.vim/ftplugin' ]; then
    echo "Create ftplugin directory."
    mkdir -p ~/.vim/ftplugin
fi

for _ft in $PRGDIR/vim/ftplugin/*
do
    if [ ! -f ~/.vim/ftplugin/${_ft} ];then
        echo "Create ${_ft} file in ftplugin directory."
        cp ${_ft} ~/.vim/ftplugin/
    fi
done

