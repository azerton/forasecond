#!/bin/bash
OUTPUTDIR=`dirname "$1"`/trimmed/
FILENAME=`basename "$1"`
echo "Outputting converted file to $OUTPUTDIR"
FILENAME_UNDERSCORED=`echo ${FILENAME// /_}`
ffmpeg -y -i "${1}" -ss 00:00:00 -t 00:00:01 -vf scale=1280:720 -vcodec libx264 -acodec copy "$OUTPUTDIR/${FILENAME_UNDERSCORED}_resized.ts";