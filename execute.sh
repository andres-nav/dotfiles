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

# Compile and install programs
function compileAndInstall() {
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
}


# Reinstall all programs that must be compiled (dmw, dwmblocks) 
if [ "$1" == "reinstall" ]; then
	compileAndInstall
fi

# Install pograms for new pc
if [ "$1" == "install" ]; then
	sudo pacman -S --needed base-devel

	git clone https://aur.archlinux.org/paru.git /tmp/paru
	cd /tmp/paru
	makepkg -si

	paru
	paru -c
	paru -S libx11 libxft libxinerama freetype2 fontconfig brightnessctl
	paru kitty fish rofi

	compileAndInstall
fi
