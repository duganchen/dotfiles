import XMonad
import XMonad.Actions.MouseResize
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Layout.WindowArranger
import XMonad.Util.EZConfig

myManageHook = composeAll
    [
    isFullscreen --> doFullFloat
    , className =? "stalonetray" --> doIgnore
    ]

conf = ewmh defaultConfig
    {
    layoutHook = avoidStruts $ windowArrange $ mouseResize $ smartBorders $ layoutHintsToCenter $ layoutHook defaultConfig
    , manageHook = manageDocks <+> manageHook defaultConfig <+> myManageHook
    , modMask = mod4Mask
    , handleEventHook = fullscreenEventHook
    , terminal = "urxvt"
    }
    `additionalKeysP`
	[
		("<Print>", spawn "scrot -e 'mv $f ~/Pictures/screenshots'")
		, ("C-M-S-e", sendMessage ToggleStruts)
		, ("C-M-S-w", spawn "nitrogen --sort=rtime ~/Pictures/wallpaper")
	]

main = xmonad =<< xmobar conf {
    startupHook = startupHook conf >> setWMName "LG3D"
}
