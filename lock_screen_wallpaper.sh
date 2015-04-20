#!/bin/bash

# Random wallpaper screenlock
#wallpapers="$HOME/Wallpapers/"
#image="$(ls ${wallpapers}*.png | shuf -n 1)"

# Pixelized screenlock
scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
image=/tmp/screen.png

/usr/bin/i3lock -i ${image}
