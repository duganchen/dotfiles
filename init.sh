#!/bin/bash
set -e
CWD=`pwd`
cd .vim/bundle/Command-T/ruby/command-t
ruby extconf.rb
make
cd ~
ln -sf $CWD/.vimrc .
ln -sf $CWD/.Xresources .
ln -sf $CWD/misc_submodules/dircolors-solarized/dircolors.256dark .dir_colors
mkdir -p .vim/autoload
cd .vim/autoload
ln -sf $CWD/misc_submodules/vim-pathogen/autoload/pathogen.vim .
cd ~/.vim
ln -sf $CWD/.vim/bundle .
cd ~
mkdir -p .mplayer
cd .mplayer
ln -sf $CWD/.mplayer/config .
mkdir -p ~/.config/Terminal
cd ~/.config/Terminal
ln -sf $CWD/misc_submodules/xfce4-terminal-colors-solarized/dark/terminalrc .
mkdir -p ~/.local/share/mc/skins
cd ~/.local/share/mc/skins
ln -sf $CWD/misc_submodules/mc-solarized-skin/solarized.ini .
