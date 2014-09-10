#!/bin/bash
# from http://swarminglogic.com/article/2014_08_whylinux

delay=0.2
title='default'
count=0
loop=1 #0 for infinite loop

# Set if you want to skip mouse selection
if [[ $# -eq 6 ]]
then
    xpos=$3
    ypos=$4
    xsize=$5
    ysize=$6
fi

if [[ $# -eq 0 ]]
then echo "./gifcapture TITLE [OUTPUTDIR] [xpos ypos xsize ysize]"
exit
fi

if [[ $# -ge 1 ]] ; then title=$1 ; fi
if [[ $# -ge 2 ]] ; then outdir=$2 ; fi
outdir=$title

if [[ ! -n $xsize || ! -n $ysize || ! -n $xpos || ! -n $ypos ]]
then
    if [ ! `which xdotool` ] ; then echo "You need xdotool!" && exit ; fi
    echo -n "Move mouse cursor to TOP LEFT of region. Press enter";
    read -n 1
    eval $(xdotool getmouselocation --shell 2>/dev/null)
    xpos=$X;
    ypos=$Y;
    echo -n "Move mouse cursor to BOTTOM RIGHT of region. Press enter";
    read -n 1
    eval $(xdotool getmouselocation --shell 2>/dev/null)
    xsize=$(($X-$xpos))
    ysize=$(($Y-$ypos))
fi

if [[ $xsize -le 0 || $ysize -le 0 ]] ; then echo "Bad region" && exit; fi

echo "Input:
----------------------------------------
xpos=$xpos
ypos=$ypos
xsize=$xsize
ysize=$ysize"
echo -n "Press enter to start recording. CTRL-C to end recoding.";
read -n 1

if [ ! -e $outdir ]
then
    mkdir $outdir
fi

finalizeGif ()
{
    # Remove potentially broken temporary file due to interrupt
    badfile=`find ./$outdir -name "*.png~"|head -n1`
    rm -f $badfile
    rm -f `sed 's/~//g' <<< $badfile`

    # Specify delay in tics for gif delay
    delayInTics=`bc <<< "$delay * 100"`

    # N Colors in gif optimization
    ncolors=256

    # Old way of creating an unoptimized gif. This creates poor results!
    # echo -n "Converting to animated gif: "
    # convert -delay 20 -loop 0 -trim  $outdir/*.png  $outdir/$title.gif
    # echo "... Done: $outdir/$title.gif";

    # Good way
    echo -n "Creating optimized animated gif:     "
    # Determine cpu cores
    nCores=`cat /proc/cpuinfo  | grep cores | head -n 1 | sed 's/.*:\s//g'`

    # Temporarily converts pngs to gifs, with good quantization.
    # Operation is quite CPU intensive and is therefore parallelized
    mkdir $outdir/tmp
    (cd $outdir && find . -name "*.png" -print0 | xargs -0 -n 1 -P $(($nCores + 1)) sh \
        -c 'nice convert $1 +dither -colors '$ncolors' ./tmp/$1.gif ' sh)

    # Creating the optimized gif. Also ignores color variations that are less than 9%
    convert -delay $delayInTics $outdir/tmp/*.gif -loop $loop -layers Optimize \
        -fuzz 9% $outdir/$title.opt.gif

    rm -rf tmp
    echo "... Done: $outdir/$title.opt.gif";
    exit 0
}

trap finalizeGif SIGINT SIGTERM

while true
do
    ((count++))
    numtext=`printf '%.3d' $count`
    nice import -window root -crop ${xsize}x${ysize}+${xpos}+${ypos} -quality 100 $outdir/${numtext}_${title}_${delay}.png
    nice mogrify -strip $outdir/${numtext}_${title}_${delay}.png
    sleep $delay
done
