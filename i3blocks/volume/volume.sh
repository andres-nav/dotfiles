#!/bin/sh

# Prints the current volume or 🔇 if muted.
mute="$(amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $4 }')"
if [ "$mute" = "off" ];
then
	echo "ﱝ mute" && exit
fi

vol="$(amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }' | rev | cut -c 2- | rev)"
if [ "$vol" -gt "70" ]; then
	icon=""
elif [ "$vol" -gt "30" ]; then
	icon=""
elif [ "$vol" -gt "0" ]; then
	icon=""
else
    icon="婢"
fi

echo "$icon $vol%"
