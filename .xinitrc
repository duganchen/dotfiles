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

# Set the path for Qt plugins provided by KDE
if test -n "$QT_PLUGIN_PATH"; then
  QT_PLUGIN_PATH="$QT_PLUGIN_PATH:`kde4-config --path qtplugins`"
else
  QT_PLUGIN_PATH="`kde4-config --path qtplugins`"
fi
export QT_PLUGIN_PATH

nvidia-settings --load-config-only
xfsettingsd
xfce4-panel &
wicd-client &
conky &
dropbox start
kdeinit4

# Start the window manager:
if [ -z "$DESKTOP_SESSION" -a -x /usr/bin/ck-launch-session ]; then
  exec fusion-icon
else
  exec /usr/bin/fusion-icon
fi
