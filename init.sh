#!/bin/sh

CWD=$( pwd )

cd ~
if [ ! -e .vimrc ]; then
	ln -sf "$CWD/.vimrc"
fi


if [ ! -d .vim ]; then
	ln -sf "$CWD/.vim"
fi

vim +PluginInstall +qall

cd ~/.vim/bundle/Command-T/ruby/command-t
ruby extconf.rb
make

cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer --system-libclang

cd ~

if [ ! -e .Xresources ]; then
	ln -s "$CWD/.Xresources"
fi

if [ ! -e .gvimrc ]; then
	ln -s "$CWD/.gvimrc"
fi

if [ ! -e .dir_colors ]; then
	ln -s "$CWD/misc_submodules/LS_COLORS/LS_COLORS" ~/.dir_colors
fi

if [ ! -e .conkyrc ]; then
	ln -s "$CWD/.conkyrc"
fi

mkdir -p .mplayer
cd .mplayer
if [ ! -e config ]; then
	ln -s "$CWD/.mplayer/config" .
fi

mkdir -p ~/.config/fontconfig
cd ~/.config/fontconfig
if [ ! -e fonts.conf ]; then
	ln -s "$CWD/.config/fontconfig/fonts.conf" .
fi

mkdir -p ~/.config/tint2
cd ~/.config/tint2
if [ ! -e tint2rc ]; then
	ln -s "$CWD/.config/tint2/tint2rc"
fi

mkdir -p ~/.config/fish
cd ~/.config/fish
if [ ! -e config.fish ]; then
	ln -s "$CWD/.config/fish/config.fish"
fi

if [ ! -e ~/.config/compton.conf ]; then
	cd ~/.config
	ln -s $CWD/.config/compton.conf
	cd -
fi
