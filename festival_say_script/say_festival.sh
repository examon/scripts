#!/bin/bash

while true;
do
	echo -n "text: "
	read text
	echo "$text" | festival --tts
done
