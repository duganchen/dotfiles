import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig

conf = ewmh defaultConfig
    {
    layoutHook = smartBorders $ layoutHintsToCenter $ layoutHook defaultConfig
    , manageHook = manageHook defaultConfig <+> composeAll [isFullscreen --> doFullFloat]
    , modMask = mod4Mask
    , terminal = "urxvt"
    }
    `additionalKeysP`
	[
		("<Print>", spawn "scrot -e 'mv $f ~/Pictures/screenshots'")
		, ("M-e", sendMessage ToggleStruts)
		, ("M-w", spawn "nitrogen --sort=rtime ~/Pictures/wallpaper")
	]

main = xmonad =<< xmobar conf {
    startupHook = startupHook conf >> setWMName "LG3D"
}
