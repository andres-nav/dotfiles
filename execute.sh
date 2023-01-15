#!/bin/bash

COPY_FOLDER="$HOME/.config/"
CURRENT_FOLDER="$(pwd)"

folders=$(echo */)

for i in $folders
do
	# rm -rf "$COPY_FOLDER$i"
	ln -fs "$CURRENT_FOLDER/$i" "$COPY_FOLDER"
done
