#!/bin/bash
set -eu

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

UpdateDir(){
    src=$1
    dist=$2

    Echo_Line 2
    [ ! -d $src ] && Echo "Not found $src, skip" && return 0
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
if type greadlink >> /dev/null 2>&1; then
    script_dir=$(greadlink -f $(dirname $0))
else
    script_dir=$(readlink -f $(dirname $0))
fi
line_cnt=100
vim_config_dir=".vim"
ftplugin_dir="${vim_config_dir}/ftplugin"
template_dir="${vim_config_dir}/template"
ftdetect_dir="${vim_config_dir}/ftdetect"
nvim_config_dir=".config/nvim"
nvim_ftplugin_dir="${nvim_config_dir}/ftplugin"
nvim_template_dir="${nvim_config_dir}/template"
nvim_ftdetect_dir="${nvim_config_dir}/ftdetect"

####================------------------------==================#####
# Body {{{1
####================------------------------==================#####
Echo_Line 1
Echo "Update vimrc and configurations"
Echo_Line 1

(
cd $script_dir

CreateDir "$HOME/${vim_config_dir}/dein"
CreateDir "$HOME/${vim_config_dir}/swap"
CreateDir "$HOME/${vim_config_dir}/backup"

CreateDir "$HOME/${nvim_config_dir}/dein"
CreateDir "$HOME/${nvim_config_dir}/swap"
CreateDir "$HOME/${nvim_config_dir}/backup"

# setup .vimrc file
Echo_Line 2
Echo "Vim"
Echo "Update .vimrc file."
cp -f vimrc $HOME/.vimrc
Echo "Update dein toml"
cp -f dein/common/* dein/vim/* $HOME/${vim_config_dir}/dein/
[ -f $HOME/${vim_config_dir}/dein/local_dein.toml ] || touch $HOME/${vim_config_dir}/dein/local_dein.toml
[ -f $HOME/${vim_config_dir}/dein/local_dein_lazy.toml ] || touch $HOME/${vim_config_dir}/dein/local_dein_lazy.toml
UpdateDir "vim/ftplugin" "$HOME/$ftplugin_dir"
UpdateDir "template" "$HOME/$template_dir"
UpdateDir "vim/ftdetect" "$HOME/$ftdetect_dir"
echo

Echo_Line 2
Echo "NeoVim"
Echo "Update init.vim file."
cp -f nvimrc $HOME/${nvim_config_dir}/init.vim
Echo "Update dein toml"
cp -f dein/common/* dein/nvim/* $HOME/${nvim_config_dir}/dein/
[ -f $HOME/${nvim_config_dir}/dein/local_dein.toml ] || touch $HOME/${nvim_config_dir}/dein/local_dein.toml
[ -f $HOME/${nvim_config_dir}/dein/local_dein_lazy.toml ] || touch $HOME/${nvim_config_dir}/dein/local_dein_lazy.toml
UpdateDir "vim/ftplugin" "$HOME/$nvim_ftplugin_dir"
UpdateDir "template" "$HOME/$nvim_template_dir"
UpdateDir "vim/ftdetect" "$HOME/$nvim_ftdetect_dir"
)

echo
Echo_Line 1
Echo "Finish"
Echo_Line 1
echo
# }}}
