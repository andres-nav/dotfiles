#!/bin/bash

COPY_FOLDER="$HOME/.config/"
CURRENT_FOLDER="$(pwd)"
EXTRA_FILES_TO_LINK="mimeapps.list"

links="$(echo */ | sed 's/\///g') $EXTRA_FILES_TO_LINK"

# Create syblinks to .config folder
for i in $links
do
	ln -fs "$CURRENT_FOLDER/$i" "$COPY_FOLDER"
done

# Reinstall all programs that must be compiled (dmw, dwmblocks) 
if [ "$1" == "reinstall" ]; then
	programs=( dwm dwmblocks )
	
	for i in "${programs[@]}"
	do
		echo "$i"
		if [[ -d $i ]] && [[ -f $i/install.sh ]]; then
			cd $i
			./install.sh
			cd $CURRENT_FOLDER
		fi
	done
fi
