import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Config.Desktop

main =  xmonad $ ewmh defaultConfig
	{
		manageHook = manageDocks <+> manageHook desktopConfig,
		layoutHook = avoidStruts $ layoutHook defaultConfig,
		terminal = "urxvt"
	}
	`additionalKeysP`
	[
		("<Print>", spawn "scrot -e 'mv $f ~/Pictures/screenshots'"),
		("M-n", sendMessage ToggleStruts)
	]


