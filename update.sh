#!/bin/bash -x

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

CreateDir(){
    target=$1
    if [ ! -d "$1" ]; then
        Echo_Line 2
        Echo "Create $target."
        mkdir -p $1
        echo ""
    else
        Echo "Already exits $target"
    fi
}

NeoBundle(){
    Echo_Line 2
    Echo "neobundle.vim."
    if [ ! -d "$HOME/$bundle_dir/neobundle.vim" ]; then
        cd $HOME/$bundle_dir
        git clone https://github.com/Shougo/neobundle.vim.git
        cd -
    else
        cd $HOME/$bundle_dir/neobundle.vim
        git pull https://github.com/Shougo/neobundle.vim.git
        cd -
    fi
    echo ""
}

UpdateDir(){
    src=$1
    dist=$2

    Echo_Line 2
    Echo "Update $dist"
    if [ ! -d $dist ]; then
        mkdir -p $dist
    fi
    cp -rf $src/* $dist
    echo ""
}

# }}}
####================------------------------==================#####
# Environment Varrables
####================------------------------==================#####
if type readlink >> /dev/null 2>&1; then
    script_dir=$(readlink -f $(dirname $0))
else
    script_dir=$(greadlink -f $(dirname $0))
fi
line_cnt=100
bundle_dir=".vim/bundle"
ftplugin_dir=".vim/ftplugin"
template_dir=".vim/template"
my_conf_dir=".vim/my_conf"

####================------------------------==================#####
# Body {{{1
####================------------------------==================#####
Echo_Line 1
Echo "Update vimrc and configurations"
Echo_Line 1

cd $script_dir

CreateDir "$HOME/$bundle_dir"
CreateDir "$HOME/.vim/swap"
CreateDir "$HOME/.vim/backup"

NeoBundle

# setup .vimrc file
Echo_Line 2
Echo "Update .vimrc file."
cp -f vimrc $HOME/.vimrc
echo ""

UpdateDir "vim/ftplugin" "$HOME/$ftplugin_dir"
UpdateDir "template" "$HOME/$template_dir"
UpdateDir "my_conf" "$HOME/$my_conf_dir"

cd -

echo ""
Echo_Line 1
Echo "Finish"
Echo_Line 1
echo ""
# }}}
