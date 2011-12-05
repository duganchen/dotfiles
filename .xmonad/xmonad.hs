import XMonad
import XMonad.Actions.UpdatePointer
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig

-- You must export SAL_USE_VCLPLUGIN=gen before using LibreOffice.
-- See: http://code.google.com/p/xmonad/issues/detail?id=200

conf = defaultConfig
              { manageHook = manageDocks <+> manageHook defaultConfig <+> composeAll
			  [ isFullscreen --> doFullFloat ]
              , layoutHook = smartBorders $ layoutHintsToCenter $ avoidStruts  $  layoutHook defaultConfig
			  , terminal = "urxvt"
			  , logHook = dynamicLog >> updatePointer (Relative 0.5 0.5)
			  , modMask = mod4Mask
			  , startupHook = setWMName "LG3D"

              }  
	`additionalKeysP`
	[
		("<Print>", spawn "scrot -e 'mv $f ~/Pictures/screenshots'"),
		("M-e", sendMessage ToggleStruts),
		("M-w", spawn "nitrogen --sort=rtime ~/Pictures/wallpaper")
	]

main = do xmonad =<< xmobar conf
