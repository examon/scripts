#!/bin/bash

mencoder -fps 30 tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0 -nosound -ovc lavc -o filename.avi
