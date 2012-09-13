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
import qualified XMonad.StackSet as W

myWorkspaces = ["1","2","3","4","5","6","7","8","9"]

myKeys =
    [
    	("<Print>", spawn "scrot -e 'mv $f ~/Pictures/screenshots'")
		, ("C-M-S-e", sendMessage ToggleStruts)
		, ("C-M-S-w", spawn "nitrogen --sort=rtime ~/Pictures/wallpaper")
    ]
    ++
    [ (mask ++ "M-" ++ [key], screenWorkspace scr >>= flip whenJust (windows . action))
         | (key, scr)  <- zip "wer" [1,0,2] -- was [0..] *** change to match your screen order ***
         , (action, mask) <- [ (W.view, "") , (W.shift, "S-")]
    ]

myManageHook = composeAll
    [
    isFullscreen --> doFullFloat
    , className =? "stalonetray" --> doIgnore
    ]

conf = ewmh defaultConfig
    {
    layoutHook = avoidStruts $ windowArrange $ mouseResize $ smartBorders $ layoutHintsToCenter $ layoutHook defaultConfig
    , manageHook = manageDocks <+> manageHook defaultConfig <+> myManageHook
    -- , modMask = mod4Mask
    , handleEventHook = fullscreenEventHook
    , terminal = "urxvt"
    }
    `additionalKeysP` myKeys

main = xmonad =<< xmobar conf {
    startupHook = startupHook conf >> setWMName "LG3D"
}
