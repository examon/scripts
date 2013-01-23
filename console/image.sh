#!/bin/sh

sudo openvt -sw -- fbi -e --autodown $1
sudo deallocvt
