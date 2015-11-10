#!/bin/bash
OUTPUTDIR=`dirname $1`/converted/
FILENAME=`basename $1`
echo "Outputting converted file to $OUTPUTDIR"
ffmpeg -y -i ${1} -vcodec libx264 -acodec copy $OUTPUTDIR/$FILENAME.ts;