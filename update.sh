#!/bin/bash

#------------------------------------------------------------------
# Update vimrc and other configurations.
#
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#------------------------------------------------------------------

CMDNAME=`basename $0`
####================------------------------==================#####
# Functions {{{
####================------------------------==================#####
Echo(){
    echo "[$CMDNAME] $1"
}

Echo_Line(){
    if [ "$1" = 1 ];then
        mark_line="################################################################################"
    elif [ "$1" = 2 ];then
        mark_line="================================================================================"
    elif [ "$1" = 3 ];then
        mark_line="--------------------------------------------------------------------------------"
    else
        mark_line="********************************************************************************"
    fi  

    echo "$mark_line"
}

Fail(){
    Echo "[ERROR] $1"
    echo ""
    exit 1
}

# }}}
####================------------------------==================#####
# Environment Varrables
####================------------------------==================#####
script_dir=$(readlink -f $(dirname $0))
line_cnt=100
bundle_dir=".vim/bundle"
ftplugin_dir=".vim/ftplugin"
template_dir=".vim/template"

####================------------------------==================#####
# Body {{{1
####================------------------------==================#####
Echo_Line 1
Echo "Update vimrc and configurations"
Echo_Line 1

pushd $script_dir

if [ ! -d "$HOME/$bundle_dir" ]; then
    Echo_Line 2
    echo " Create directory at HOME."
    mkdir -p $HOME/$bundle_dir
    echo ""
fi

if [ ! -d "$HOME/.vim/swap" ]; then
    Echo_Line 2
    echo " Create swap directory at HOME."
    mkdir -p $HOME/.vim/swap
    echo ""
fi

if [ ! -d "$HOME/.vim/backup" ]; then
    Echo_Line 2
    echo " Create backup directory at HOME."
    mkdir -p $HOME/.vim/backup
    echo ""
fi

if [ ! -d "$HOME/$bundle_dir/neobundle.vim" ]; then
    Echo_Line 2
    echo " Get neobundle.vim."
    pushd $HOME/$bundle_dir
    git clone https://github.com/Shougo/neobundle.vim.git
    popd
    echo ""
else
    Echo_Line 2
    echo " Update neobundle.vim."
    pushd $HOME/$bundle_dir/neobundle.vim
    git pull https://github.com/Shougo/neobundle.vim.git
    popd
    echo ""
fi

# setup .vimrc file
Echo_Line 2
echo " Update .vimrc file."
cp -f vimrc $HOME/.vimrc
echo ""

# setup ftplugin
if [ ! -d "$HOME/$ftplugin_dir" ]; then
    Echo_Line 2
    echo " Update filetype directory."
    cp -rf vim/ftplugin $HOME/.vim/$template_dir
    echo ""
else
    Echo_Line 2
    echo " Update filetype files."
    cp vim/ftplugin/*.vim $HOME/$ftplugin_dir/
    echo ""
fi

# setup template
if [ ! -d "$HOME/$template_dir" ]; then
    Echo_Line 2
    echo " Update template directory."
    cp -rf template $HOME/.vim/
    echo ""
else
    Echo_Line 2
    echo " Update template files."
    cp template/* $HOME/$template_dir
    echo ""
fi

popd

echo ""
Echo_Line 1
Echo "Finish"
Echo_Line 1
echo ""
# }}}
####================------------------------==================#####
