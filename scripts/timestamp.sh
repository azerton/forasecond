#!/bin/bash
DIRNAME=`dirname "$1"`
OUTPUTDIR=`dirname "$1"`/trimmed/
FILENAME=`basename "$1"`

ffmpeg -y -i "$DIRNAME/trimmed/$FILENAME.ts" -vf drawtext="fontfile=/Users/draman/Library/Fonts/Swiss-721-WGL4-BT_43266.ttf: \
		fontcolor=white@0.8: fontsize=24: \
		expansion=strftime:basetime=$(date +%s)000000: \
	    text='$newline %b %d, %Y $newline': \
		x=(w-text_w)-30: y=20" -vcodec libx264 -acodec libvo_aacenc "$DIRNAME/trimmed/${FILENAME}_txt.ts";		
		
		
