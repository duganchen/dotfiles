import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks

main =  xmonad $ ewmh defaultConfig
	{
		manageHook = manageDocks <+> manageHook defaultConfig,
		layoutHook = avoidStruts $ layoutHook defaultConfig,
		terminal = "urxvt"
	}
	`additionalKeysP`
	[
		("<Print>", spawn "scrot -e 'mv $f ~/Pictures/screenshots'")
	]

