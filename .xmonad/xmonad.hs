import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig

-- conf = ewmh defaultConfig
-- main = do xmonad =<< xmobar conf

conf = ewmh defaultConfig
    {
    layoutHook = smartBorders $ layoutHintsToCenter $ layoutHook defaultConfig
    , manageHook = composeAll [isFullscreen --> doFullFloat]
    , modMask = mod4Mask
    , startupHook = setWMName "LG3D"
    , terminal = "urxvt"
    }
 	`additionalKeysP`
 	[
 		("<Print>", spawn "scrot -e 'mv $f ~/Pictures/screenshots'")
 		, ("M-e", sendMessage ToggleStruts)
 		, ("M-w", spawn "nitrogen --sort=rtime ~/Pictures/wallpaper")
 	]

main = do xmonad =<< xmobar conf

-- import XMonad.Hooks.DynamicLog
-- import XMonad.Hooks.ICCCMFocus
-- import XMonad.Hooks.ManageDocks
-- import XMonad.Hooks.ManageHelpers
-- import XMonad.Hooks.SetWMName
-- import XMonad.Layout.LayoutHints
-- import XMonad.Layout.NoBorders
-- import XMonad.Util.EZConfig


-- You must export SAL_USE_VCLPLUGIN=gen before using LibreOffice.
-- See: http://code.google.com/p/xmonad/issues/detail?id=200

-- conf = defaultConfig
--     { manageHook = manageDocks <+> manageHook defaultConfig <+> composeAll
-- 	    [ isFullscreen --> doFullFloat ]
--         , layoutHook = avoidStruts $ layoutHintsToCenter $ smartBorders $ layoutHook defaultConfig
-- 		, logHook = takeTopFocus
-- 		, modMask = mod4Mask
-- 		, startupHook = setWMName "LG3D"
-- 		, terminal = "urxvt"
--     }  
-- 	`additionalKeysP`
-- 	[
-- 		("<Print>", spawn "scrot -e 'mv $f ~/Pictures/screenshots'")
-- 		, ("M-e", sendMessage ToggleStruts)
-- 		, ("M-w", spawn "nitrogen --sort=rtime ~/Pictures/wallpaper")
-- 	]
-- 
-- main = do xmonad =<< xmobar conf
