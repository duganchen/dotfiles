#!/bin/sh
# $XConsortium: xinitrc.cpp,v 1.4 91/08/22 11:41:34 rws Exp $

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f $userresources ]; then
    xrdb -merge $userresources
fi

if [ -f $usermodmap ]; then
    xmodmap $usermodmap
fi

# Loading of gnome-settings-daemon or xfsettingsd removed.
# Use a theme switcher for the GTK theme, and manipulate
# /etc/fonts/conf.d for the font settings.

# Set the path for Qt plugins provided by KDE
if test -n "$QT_PLUGIN_PATH"; then
  QT_PLUGIN_PATH="$QT_PLUGIN_PATH:`kde4-config --path qtplugins`"
else
  QT_PLUGIN_PATH="`kde4-config --path qtplugins`"
fi
export QT_PLUGIN_PATH

# Preload stuff for KDE apps
if which start_kdeinit >/dev/null; then
  LD_BIND_NOW=true start_kdeinit --new-startup +kcminit_startup &
fi

nvidia-settings --load-config-only
wicd-client &
dropbox start
nitrogen --restore
xsetroot -cursor_name left_ptr
trayer --edge top --align right --SetDockType true --SetPartialStrut true \
 --expand true --width 10 --transparent true --tint 0x191970 --height 21 &

# Start the window manager:
if [ -z "$DESKTOP_SESSION" -a -x /usr/bin/ck-launch-session ]; then
  exec ck-launch-session /usr/bin/xmonad
else
  exec /usr/bin/xmonad
fi
