#!/bin/zsh
WALLPAPER=$(shuf -en1 /home/$USER/Pictures/wallpapers/*)
cp "$WALLPAPER" /home/$USER/Pictures/wallpaper.jpg
