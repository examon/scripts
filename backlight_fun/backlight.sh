#!/bin/bash

for n in {1..10}
do
	for i in {1..15}
	do
		echo on > /proc/acpi/ibm/light
		echo $i > /sys/class/backlight/acpi_video0/brightness
		sleep 0.1s
	done
		echo off > /proc/acpi/ibm/light

	for i in {15..1}
	do
		echo on > /proc/acpi/ibm/light
		echo $i > /sys/class/backlight/acpi_video0/brightness
		sleep 0.1s
	done
		echo off > /proc/acpi/ibm/light
done
