#!/bin/sh

( xrandr --output eDP-1 --primary --output HDMI-1 --off --output DP-1 --off ) &
( xrandr --output HDMI-1-0 --auto --right-of eDP-1 ) &

( feh -z ~/.config/wallpapers --bg-fill ) &

#( killall /opt/vscodium-bin/codium && sleep 1 && codium ) &

