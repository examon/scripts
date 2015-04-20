#!/bin/bash
set -e

if test -e profile.png; then
  trash profile.png
fi

if test -e profile.dat; then
  trash profile.dat
fi

/usr/bin/python3 -m cProfile -s tottime -o $PWD/profile.dat $@
gprof2dot -f pstats $PWD/profile.dat | dot -Tpng -o $PWD/profile.png
feh $PWD/profile.png

