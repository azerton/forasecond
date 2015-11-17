#!/bin/bash
DIRNAME=`dirname "$1"`
OUTPUTDIR=`dirname "$1"`/trimmed/
FILENAME=`basename "$1"`

ffmpeg -y -i "$DIRNAME/converted/$FILENAME.ts" -ss 00:00:00 -t 00:00:01 -vcodec libx264 -acodec copy -y  "$DIRNAME/trimmed/$FILENAME.ts";		
#ffmpeg -y -i $DIRNAME/$FILENAME -ss 00:00:00 -t 00:00:01 -vcodec libx264 -acodec libvo_aacenc -y  $DIRNAME/trimmed/$FILENAME;
