#!/bin/sh

while true;
do
	echo $(date "+%A %d %b %Y, %H hours %M minutes") | festival --tts
	sleep 1h
done
