#!/bin/env bash
set -e
CWD=`pwd`
cd .vim/bundle/Command-T/ruby/command-t
ruby extconf.rb
make
cd ~
ln -sf $CWD/.vimrc .
ln -sf $CWD/.Xresources .
ln -sf $CWD/.gvimrc .
ln -sf $CWD/misc_submodules/dircolors-solarized/dircolors.256dark .dir_colors
mkdir -p .vim/autoload
cd .vim/autoload
ln -sf $CWD/misc_submodules/vim-pathogen/autoload/pathogen.vim .
cd ~/.vim
ln -sf $CWD/.vim/bundle .
cd bundle
ln -sf $CWD/misc_submodules/solarized/vim-colors-solarized .
cd ~
mkdir -p .mplayer
cd .mplayer
ln -sf $CWD/.mplayer/config .
mkdir -p ~/.config/Terminal
cd ~/.config/Terminal
cp $CWD/misc_submodules/solarized/xfce4-terminal/dark/terminalrc .
mkdir -p ~/.local/share/mc/skins
cd ~/.local/share/mc/skins
ln -sf $CWD/misc_submodules/mc-solarized-skin/solarized.ini .
mkdir -p ~/.config/fontconfig
cd ~/.config/fontconfig
ln -s $CWD/.config/fontconfig/fonts.conf .
