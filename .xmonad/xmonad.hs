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
		("M-n", sendMessage ToggleStruts)
	]

main = do
	xmonad conf
		{
			-- To make Netbeans works. Should be unncessary with JDK7.
			startupHook = startupHook conf >> setWMName "LG3D"
		}
