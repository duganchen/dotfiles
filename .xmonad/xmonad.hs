
import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Actions.UpdatePointer
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders
import XMonad.Layout.LayoutHints

conf = defaultConfig
              { manageHook = manageDocks <+> manageHook defaultConfig
              , layoutHook = smartBorders $ layoutHintsToCenter $ avoidStruts  $  layoutHook defaultConfig
			  , terminal = "urxvt"
			  , logHook = dynamicLog >> updatePointer (Relative 0.5 0.5)
			  , modMask = mod4Mask

              }  
	`additionalKeysP`
	[
		("<Print>", spawn "scrot -e 'mv $f ~/Pictures/screenshots'"),
		("M-e", sendMessage ToggleStruts),
		("M-w", spawn "nitrogen --sort=rtime ~/Pictures/wallpaper")
	]

main = do xmonad =<< xmobar conf


			  

