import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig
import XMonad.Hooks.EwmhDesktops

main =  xmonad $ ewmh defaultConfig `additionalKeysP` [("<Print>", spawn "scrot -e 'mv $f ~/Pictures/screenshots'")]

