
from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget
from libqtile import hook
import datetime
import os
import subprocess

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])
mod = "mod4"
global old
@lazy.function
def fullwm(qtile):
    global old
    layout=qtile.currentLayout.name
#    qtile.cmd_spawn('gedit {}'.format(layout))
    if layout != "max":
        old=layout
        qtile.cmd_to_layout_index(1)
    else:
        if old == "monadtall":
            qtile.cmd_to_layout_index(0)
        elif old == "columns":
            qtile.cmd_to_layout_index(2)
        elif old == "verticaltile":
            qtile.cmd_to_layout_index(3)
        elif old == "matrix":
            qtile.cmd_to_layout_index(4)
        elif old == "zoomy":
            qtile.cmd_to_layout_index(5)

keys = [
    #controles de tela setas sozinhas só mudam o foco
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Up", lazy.layout.up()),
    #seta+shift muda aonde o foco está
    Key([mod, "shift"], "Left", lazy.layout.swap_left()),
    Key([mod, "shift"], "Right", lazy.layout.swap_right()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    #controla o tamanho do foco
    Key([mod, "control"], "Up", lazy.layout.grow()),
    Key([mod, "control"], "Down", lazy.layout.shrink()),
    # n deixa do tamanho original, e m maimiza o foco
    Key([mod], 'n', lazy.layout.normalize()),
    Key([mod, "shift"], "n", lazy.layout.reset()),
    Key([mod], "m", lazy.layout.maximize()),
    #shift+m muda para o layout max, e volta ao original
    Key([mod, "shift"], "m", fullwm),
    Key([mod], 't', lazy.window.toggle_floating()),
    #espaço vai para proximo layout 
    #shift vai para o modo fullscreen,diferente do m, ele tira a barra e é full screen total(muda no navegador
    #por exemplo)
    #control volta para o layout anterior
    Key([mod], "space", lazy.next_layout()),
    Key([mod, "shift"], "space", lazy.window.toggle_fullscreen()),
    Key([mod, "control"], "space", lazy.prev_layout()),
    #b some com a barra de cima e de baixo
    Key([mod], "b", lazy.hide_show_bar("top")),
    Key([mod], "b", lazy.hide_show_bar("bottom")),

    #comandos
    Key([mod], "Return", lazy.spawn("terminator")),
    Key([mod], "f", lazy.spawn("firefox")),
    
    
    Key([mod], "Print", lazy.spawn("scrot -e 'mv $f ~/pictures/screenshots/'")),
    Key([mod], "q", lazy.window.kill()),
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    #lança o launcher
    Key([mod], "d", lazy.spawn("rofi -show run -lines 2 -eh 1 -width 100 -padding 0 -opacity '95' -bw 0 -bc '$bg-color' -bg '$bg-color' -fg '$text-color' -hlbg '$bg-color' -hlfg '#9575cd' -font 'System San Francisco Display 10' -location 1 —auto-select")),
    
]

groups = [Group(i) for i in "1234567890"]

for i in groups:
    # mod1 + letter of group = switch to group
    keys.append(
        Key([mod], i.name, lazy.group[i.name].toscreen())
    )

    # mod1 + shift + letter of group = switch to & move focused window to group
    keys.append(
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name))
    )

layouts = [
    layout.MonadTall(),
    layout.Max(),
    layout.Columns(),
    layout.VerticalTile(),
    layout.Matrix(),
    layout.Zoomy(),
]

widget_defaults = dict(
    font='Arial',
    fontsize=14,
    padding=3,
)

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.Sep(),
                widget.WindowName(),
                widget.Sep(),
                widget.Wlan(interface="wlp6s0"),
                widget.Sep(),
                widget.CheckUpdates(),
                widget.Sep(),
                widget.Battery(format="battery: {char} {percent:2.0%} {hour:d}:{min:02d}"),

                widget.Volume(),
                widget.Sep(),
                widget.Systray(),
                widget.Sep(),
                widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
            ],
            30,
        ),
         bottom=bar.Bar(
            [
                widget.GroupBox(),
                widget.Sep(),
                widget.CPUGraph(),
                widget.Memory(),
                widget.MemoryGraph(),
                widget.Sep(),
                widget.Backlight(backlight_name="intel_backlight",format="bright: {percent:2.0%}"),
                widget.Sep(),
                widget.Wallpaper(directory=os.path.expanduser("~/Pictures/wallpapers"),random_selection=True),
                widget.Sep(),
                widget.Pacman(),
                widget.Volume(),
               
            ],
            30,
        ),
    )
]

# Drag flzaoating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating() 
auto_fullscreen = True
focus_on_window_activation = "smart"
extentions = []

wmname = "LG3D"
