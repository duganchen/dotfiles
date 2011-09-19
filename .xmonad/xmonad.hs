import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Config.Desktop
import XMonad.Layout.LayoutHints
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageHelpers

conf = ewmh defaultConfig
	{
		modMask = mod4Mask
		, manageHook = manageDocks <+> manageHook defaultConfig <+> composeAll
		[
			isFullscreen --> doFullFloat
		]
		, layoutHook = smartBorders $ layoutHintsToCenter $ avoidStruts $ layoutHook defaultConfig 
		, terminal = "urxvt"
	}
	`additionalKeysP`
	[
		("<Print>", spawn "scrot -e 'mv $f ~/Pictures/screenshots'"),
		("M-e", sendMessage ToggleStruts),
		("M-w", spawn "nitrogen --sort=rtime ~/Pictures/wallpaper")
	]

main = do
	xmonad =<< xmobar conf
		{
			startupHook = startupHook conf >> setWMName "LG3D"
		}
