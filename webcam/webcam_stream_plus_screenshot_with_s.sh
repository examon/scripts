#!/bin/bash

mplayer -vf screenshot -fps 30 tv:// -tv driver=v4l2:device=/dev/video0
