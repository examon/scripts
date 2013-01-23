#!/bin/bash

# general backup -> external HDD
rsync -av --progress --delete /home/exo/ /media/truecrypt1/backup/
