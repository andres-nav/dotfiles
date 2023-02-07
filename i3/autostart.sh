#!/bin/sh

( xrandr --output eDP1 --primary --output HDMI1 --off --output DP1 --off ) &
( xrandr --output HDMI-1-0 --auto --right-of eDP1 ) &

( feh -z /home/me/.config/wallpapers --bg-fill ) &

#( killall /opt/vscodium-bin/codium && sleep 1 && codium ) &

