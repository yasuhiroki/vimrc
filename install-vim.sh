#!/bin/bash -e

apt-get build-dep vim 
apt install mercurial gettext libncurses5-dev libacl1-dev libgpm-dev lua5.2 liblua5.2-dev luajit libluajit-5.1 libperl-dev python-dev python3-dev ruby-dev

vim_src_dir="vim-src"
[ ! -d ${vim_src_dir} ] && hg clone https://vim.googlecode.com/hg/ ${vim_src_dir}
cd ${vim_src-dir}/src
./configure  --with-features=huge --enable-gui=gnome2 --enable-perlinterp --enable-pythoninterp --enable-python3interp --enable-rubyinterp --enable-luainterp --with-luajit --enable-fail-if-missing
make
make install

