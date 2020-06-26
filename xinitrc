#!/bin/sh
#
# ~/.xinitrc
#

# dwm:
# ----
xset s 100 1 # screen lock timeout
xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock &
xmodmap $HOME/.Xmodmap
# feh --bg-scale ~/.wallpaper.jpg &
redshift -O 3250
pamixer -m

# dwmbar_loop.sh &
$HOME/go/src/github.com/thomasheller/godwmbar/godwmbar &

exec $HOME/go/src/github.com/thomasheller/dwm/dwm

# bspwm:
# ------
# exec bspwm

