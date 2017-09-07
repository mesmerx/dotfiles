import XMonad
import Data.Monoid
import System.Exit
import XMonad.Util.Run

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad.Actions.CycleWS
import XMonad.Hooks.Place 

import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders 
import qualified XMonad.Actions.FlexibleResize as Flex

import XMonad.Layout.MouseResizableTile

import XMonad.Layout.Minimize

import XMonad.Actions.WindowBringer

import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.FadeWindows 
import XMonad.Hooks.FadeInactive

main = xmonad =<< statusBar myBar myPP toggleStrutsKey defaults
myBar = "xmobar"
myPP = xmobarPP { 
	ppTitle =xmobarColor "green" "" . wrap "[" "]"
	, ppSep = " " 
	, ppLayout = myLayoutPrinter
	, ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" 
	}
myLayoutPrinter :: String -> String
myLayoutPrinter "Minimize MouseResizableTile" = xmobarColor "red" "" "[|]"
myLayoutPrinter "Minimize Full" = xmobarColor "green" "" "[ ]"
myLayoutPrinter "Minimize Mirror MouseResizableTile" = xmobarColor "blue" "" "[-]"
myLayoutPrinter x = xmobarColor "white" "" x
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

defaults = defaultConfig {

      terminal    = myTerminal
    , focusFollowsMouse = myFocusFollowsMouse
    , workspaces = myWorkspaces
    , borderWidth = myBorderWidth
    , modMask     = myModMask

    , keys               = myKeys
    , mouseBindings      = myMouseBindings
    , logHook = myLogHook 
    , layoutHook   = myLayout
    , manageHook   = manageDocks <+> myManageHook <+> manageHook defaultConfig
    , startupHook  = myStartupHook
    }

myTerminal    = "terminator"
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
myModMask     = mod4Mask 
myBorderWidth = 1

myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount
     where fadeAmount = 0.8

myStartupHook :: X ()
myStartupHook = do
    spawn "setxkbmap -model abnt2 -layout br -variant abnt2 "
    spawn "xmobar ~/.xmobarrc2"
    spawn "stalonetray &"
    spawn "nm-applet"
    spawn "xcompmgr -c -C -t-5 -l-5 -r4.2 -o.55 -f &"

myWorkspaces    = ["1", "2", "3", "4"]

myLayout = id
     . XMonad.Layout.NoBorders.smartBorders
     . avoidStruts
     . minimize
     . mkToggle (NOBORDERS ?? FULL ?? EOT)
     . mkToggle (MIRROR ?? EOT)
     $ (tiled ||| Mirror tiled ||| full )
  where
     tiled = mouseResizableTile {
             masterFrac = 0.5,
             fracIncrement = 0.05,
             draggerType = BordersDragger
     }
     full = noBorders Full

myManageHook =
    placeHook (inBounds (underMouse (0.5, 0.5)))  
  <+> composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore ]


myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    [ ((modm, button3), (\w -> focus w >> mouseMoveWindow w))

    , ((modm, button2), (\w -> focus w >> windows W.swapMaster >> windows W.swapUp))

    , ((modm, button1), (\w -> focus w >> Flex.mouseResizeEdgeWindow 0.5 w))

    ]

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, xK_Return), spawn $ XMonad.terminal conf)

    
    , ((modm              , xK_f     ), spawn "firefox")
    , ((modm              , xK_i     ), spawn "i3lock -c 000000 -n")
    , ((modm              , xK_p     ), spawn "spotify")
    , ((modm              , xK_c     ), spawn "nmcli_dmenu")
    , ((modm .|. controlMask, xK_t     ), spawn "telegram-desktop")
    , ((modm              , xK_b     ), sendMessage ToggleStruts)
    , ((0, xK_Print), spawn "mkdir -p ~/pictures/screenshots & scrot -q 1 ~/pictures/screenshots/%Y-%m-%d-%H:%M:%S.png")

    , ((modm,               xK_d     ), spawn "rofi -show run -lines 2 -eh 1 -width 100 -padding 0 -opacity '95' -bw 0 -bc '$bg-color' -bg '$bg-color' -fg     '$text-color' -hlbg '$bg-color' -hlfg '#9575cd' -font 'System San Francisco Display 10' -location 1 --auto-select")
    , ((modm, xK_q     ), kill)

    , ((modm, xK_w     ), withFocused minimizeWindow)
    , ((modm .|. shiftMask, xK_w     ), sendMessage RestoreNextMinimizedWin)


    , ((modm,               xK_space ), sendMessage NextLayout)

    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    , ((modm,               xK_n     ), refresh)

    , ((modm,               xK_Right   ), windows W.focusDown)

    , ((modm,               xK_Right     ), windows W.focusDown)

    , ((modm,               xK_Left     ), windows W.focusUp  )

    , ((modm,               xK_m     ), windows W.focusMaster  )


    , ((modm,               xK_Down     ), windows W.swapDown  )

    , ((modm,               xK_Up     ), windows W.swapUp    )

    , ((modm .|. shiftMask, xK_Left     ), sendMessage Shrink)

    , ((modm .|. shiftMask, xK_Right     ), sendMessage Expand)

    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    , ((modm, xK_a), sequence_ [
                     withFocused $ windows . W.sink, 
                     sendMessage $ Toggle FULL  
                     ])


    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))


    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    , ((modm .|. shiftMask, xK_r     ), spawn "xmonad --recompile; xmonad --restart")

    , ((modm,               xK_Next),  moveTo Next HiddenWS)
    , ((modm,               xK_Prior), moveTo Prev HiddenWS)
    , ((modm .|. shiftMask, xK_Next),  shiftTo Next HiddenWS >> moveTo Next HiddenWS) 
    , ((modm .|. shiftMask, xK_Prior), shiftTo Prev HiddenWS >> moveTo Prev HiddenWS) 

    , ((modm .|. controlMask, xK_j), moveTo Next HiddenWS)
    , ((modm .|. controlMask, xK_k), moveTo Prev HiddenWS)
    , ((modm .|. shiftMask .|. controlMask, xK_j), shiftTo Next HiddenWS >> moveTo Next HiddenWS)
    , ((modm .|. shiftMask .|. controlMask, xK_k), shiftTo Prev HiddenWS >> moveTo Prev HiddenWS)

 
    , ((modm,               xK_z), shiftNextScreen >> nextScreen) 
    , ((modm .|. shiftMask, xK_z), swapNextScreen)

    ] 
    ++
 
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
 
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
