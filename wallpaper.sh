#!/bin/zsh
USER=$(whoami)
WALLPAPER=$(shuf -en1 /home/$USER/Pictures/wallpapers/*)
cp "$WALLPAPER" /home/$USER/Pictures/wallpaper.jpg
