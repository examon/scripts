#!/bin/bash


ffmpeg -f x11grab -s 1920x1080 -r 25 -i :0.0 -sameq output.mkv
