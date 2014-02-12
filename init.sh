#!/bin/env bash
set -e
CWD=`pwd`
cd .vim/bundle/Command-T/ruby/command-t
ruby extconf.rb
make

cd .vim/bundle/vimproc
make

cd ~

if [ ! -e .vimrc ]; then
	ln -sf $CWD/.vimrc
fi

if [ ! -e .Xresources ]; then
	ln -sf $CWD/.Xresources
fi

if [ ! -e .gvimrc ]; then
	ln -sf $CWD/.gvimrc
fi

if [ ! -e .dir_colors ]; then
	ln -s $CWD/misc_submodules/LS_COLORS/LS_COLORS ~/.dir_colors
fi

if [ ! -e .conkyrc ]; then
	ln -s $CWD/.conkyrc
fi

mkdir -p .mplayer
cd .mplayer
if [ ! -e config ]; then
	ln -sf $CWD/.mplayer/config .
fi

mkdir -p ~/.config/fontconfig
cd ~/.config/fontconfig
if [ ! -e fonts.conf ]; then
	ln -s $CWD/.config/fontconfig/fonts.conf .
fi

mkdir -p ~/.config/tint2
cd ~/.config/tint2
if [ ! -e tintrc ]; then
	ln -s $CWD/.config/tint2/tintr2rc
fi

mkdir -p ~/.vim/autoload
cd ~/.vim/autoload
ln -sf $CWD/misc_submodules/vim-pathogen/autoload/pathogen.vim .
cd ~/.vim
ln -sf $CWD/.vim/bundle .
