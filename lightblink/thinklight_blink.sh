#!/bin/bash

#for i in {1..5}
while (true)
do
    read -p ""
    echo on > /proc/acpi/ibm/light
    sleep 0.2s
    echo off > /proc/acpi/ibm/light
done

