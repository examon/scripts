#!/bin/sh

sudo openvt -sw -- mplayer -really-quiet -vo fbdev -fs $1
