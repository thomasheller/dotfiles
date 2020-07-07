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
xsetroot -solid black
redshift -O 3250
pamixer -m

if [ -x $HOME/go/src/github.com/thomasheller/godwmbar/godwmbar ]; then
	$HOME/go/src/github.com/thomasheller/godwmbar/godwmbar &
else
	dwmbar_loop.sh &
fi

hostname | grep TH && xrandr --output eDP-1 --mode 1600x900
exec $HOME/go/src/github.com/thomasheller/dwm/dwm

# bspwm:
# ------
# exec bspwm

