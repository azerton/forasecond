#!/bin/bash
DIRNAME=`dirname $1`
OUTPUTDIR=`dirname $1`/trimmed/
FILENAME=`basename $1`

ffmpeg -y -i $DIRNAME/trimmed/$FILENAME.ts -vf scale=1280:720 -vcodec libx264 -acodec copy $DIRNAME/trimmed/${FILENAME}_resized.ts;
