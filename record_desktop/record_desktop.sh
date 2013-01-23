#!/bin/bash

echo -n "framerate: "
read framerate
echo -n "resolution: "
read res
echo -n "queality (1 == best): "
read quality
echo -n "save path: "
read save

ffmpeg -r $framerate -s $res -f x11grab -i :0.0 -vcodec msmpeg4v2 -qscale $quality $save
