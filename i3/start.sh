#!/usr/bin/sh

setxkbmap -option ctrl:swap_lalt_lctl
setxkbmap -option caps:swapescape

xset r rate 220 30

( xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Tapping Enabled" 1 ) &
( xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Middle Emulation Enabled" 1 ) &

( unclutter -grab ) &

( killall megasync ; sleep 5 ; megasync) &

# exec dbus-launch --autolaunch=$(cat /var/lib/dbus/machine-id) /usr/bin/i3
exec /usr/bin/i3
