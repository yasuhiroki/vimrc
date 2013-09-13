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
echo " This is startup tool."
echo " Execution in $PRGDIR."
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"

# git clone NeoBundle on ~/.vim/bundle
BUNDLE_DIR=".vim/bundle"
if [ ! -d "$HOME/$BUNDLE_DIR" ]; then
    echo "====================================================="
    echo " Create directory at HOME."
    mkdir -p $HOME/$BUNDLE_DIR
    echo ""
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

if [ ! -d "$HOME/$BUNDLE_DIR/neobundle.vim" ]; then
    echo "====================================================="
    echo " Get neobundle.vim."
    pushd $HOME/$BUNDLE_DIR
    git clone https://github.com/Shougo/neobundle.vim.git
    popd
    echo ""
fi

# setup .vimrc file
if [ ! -f "$HOME/.vimrc" ]; then
    echo "====================================================="
    echo " Copy .vimrc file."
    cp vimrc $HOME/.vimrc
    echo ""
fi

# setup ftplugin
FTPLUGIN_DIR=".vim/ftplugin"
if [ ! -d "$HOME/$FTPLUGIN_DIR" ]; then
    echo "====================================================="
    echo " Create ftplugin directory."
    mkdir -p $HOME/$FTPLUGIN_DIR
    echo ""
fi

for _ft in vim/ftplugin/*.vim
do
    if [ ! -f "$HOME/$FTPLUGIN_DIR/${_ft##*/}" ];then
        echo "====================================================="
        echo " Create ${_ft##*/} file in ftplugin directory."
        cp ${_ft} $HOME/$FTPLUGIN_DIR/
    fi
done
echo ""

# color solarized
COLORS_DIR=".vim/colors"
#if [ ! -d "$HOME/$COLORS_DIR" ];then
#    echo "====================================================="
#    echo " Create colors directory."
#    mkdir -p $HOME/$COLORS_DIR
#fi
#
#if [ ! -f "$HOME/$COLORS_DIR/solarized.vim" ];then
#    echo "====================================================="
#    echo " Get and Set solarized.vim."
#    pushd $HOME/$COLORS_DIR
#    git clone https://github.com/altercation/vim-colors-solarized.git
#    cp vim-colors-solarized/colors/solarized.vim .
#    popd
#fi

# setup template
TEMPLATE_DIR=".vim/template"
if [ ! -d "$HOME/$TEMPLATE_DIR" ]; then
    echo "====================================================="
    echo " Create template directory."
    cp -r template $HOME/.vim/
    echo ""
else
    echo "====================================================="
    echo " Create template files."
    cp template/* $HOME/$TEMPLATE_DIR
    echo ""
fi

echo ""
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo " Finish start-up."
echo "====================================================="
echo ""

