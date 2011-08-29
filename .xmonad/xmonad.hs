import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig

main=xmonad=<< dzen myConfig
myConfig=defaultConfig `additionalKeysP` [("<Print>", spawn "scrot -e 'mv $f ~/Pictures/screenshots'")]
