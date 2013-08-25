#!/bin/bash

# Start-up for vim settings
if [ ! -f 'vimrc' ] \
    && [ ! -d 'vim' ] \
    && [ ! -f 'startup.sh' ]; then

    echo ""
    echo "Plase execute in vimrc directory that you ran git clone."
    exit 1
fi

PRGDIR=`pwd`
echo ""
echo "====================================================="
echo " This is update tool."
echo " Execution in $PRGDIR."
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"

# git clone NeoBundle on ~/.vim/bundle
BUNDLE_DIR=".vim/bundle"
if [ ! -d "$HOME/$BUNDLE_DIR" ]; then
    echo "[Error] Could not Found .vim/bundle directory."
    echo ""
    exit 1
fi


if [ ! -d "$HOME/.vim/swap" ]; then
    echo "====================================================="
    echo " Create swap directory at HOME."
    mkdir -p $HOME/.vim/swap
    echo ""
fi

if [ ! -d "$HOME/.vim/backup" ]; then
    echo "====================================================="
    echo " Create backup directory at HOME."
    mkdir -p $HOME/.vim/backup
    echo ""
fi

if [ -d "$HOME/$BUNDLE_DIR/neobundle.vim" ]; then
#    echo "====================================================="
#    echo " Update neobundle.vim."
#    pushd $HOME/$BUNDLE_DIR
#    git pull https://github.com/Shougo/neobundle.vim.git
#    popd
    echo "[NOTICE] Skip update neobundle.vim"
    echo ""
fi

# setup .vimrc file
if [ -f "$HOME/.vimrc" ]; then
    echo "====================================================="
    echo " Update .vimrc file."
    cp vimrc $HOME/.vimrc
    echo ""
fi

# setup ftplugin
FTPLUGIN_DIR=".vim/ftplugin"
if [ ! -d "$HOME/$FTPLUGIN_DIR" ]; then
    echo "[Error] Could not found ftplugin directory."
    echo ""
fi

for _ft in vim/ftplugin/*.vim
do
    if [ -f "$HOME/$FTPLUGIN_DIR/${_ft##*/}" ];then
        echo "====================================================="
        echo " Update filetype ${_ft##*/}."
        cp ${_ft} $HOME/$FTPLUGIN_DIR/
    else
        echo "====================================================="
        echo " Add filetype ${_ft##*/}."
        cp ${_ft} $HOME/$FTPLUGIN_DIR/
    fi
done
echo ""

echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo " Finish start-up."
echo "====================================================="
echo ""

