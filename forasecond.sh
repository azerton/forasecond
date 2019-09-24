#!/bin/bash
PROJDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ $# -eq 0 ]
  then
    echo "No arguments supplied! You need to specify as single argument the folder in which all movie clips are stored (will include all subfolders)"
    exit
fi

#Handle spaces in filenames
OIFS="$IFS"
IFS=$'\n'

# Move to the project parent folder
cd "$PROJDIR"
MOVPATH=$1

# Convert and trim all raw clips
mkdir "$PROJDIR/tmp/trimmed"
rm $PROJDIR/tmp/trimmed/*.ts

# Empty the file list
> $PROJDIR/tmp/input.txt

# Iterate over all video files in subfolders, and make sure they are outputted chronologically by the creation date of the file (from newer to older)
for f in `find "$MOVPATH" -type f -name "*.mov" -print0 -o -name "*.MOV" -print0 -o -name "*.mp4" -print0 -o -name "*.MP4" -print0 |xargs -0 stat -f '%c %N'|sort -r|cut -d ' ' -f 2-`;
do
	echo "Processing $f"

  OUTPUTDIR="$PROJDIR/tmp/trimmed"
  FILENAME=`basename "$f"`
  echo "Outputting converted file to $OUTPUTDIR"
  FILENAME_UNDERSCORED=`echo ${FILENAME// /_}`
  RANDSTR=`openssl rand -hex 20`
  ffmpeg -y -i "$f" -ss 00:00:00 -t 00:00:01 -vf "scale=min(iw*720/ih\,1280):min(720\,ih*1280/iw),pad=1280:720:(1280-iw)/2:(720-ih)/2" -vcodec libx264 -acodec copy "$OUTPUTDIR/${RANDSTR}.ts";

  if test -f "$OUTPUTDIR/${RANDSTR}.ts"; then
    echo "file $OUTPUTDIR/${RANDSTR}.ts" >> tmp/input.txt
	fi
	echo ""
done

ffmpeg -y -f concat -analyzeduration 100M -probesize 100M -safe 0 -i tmp/input.txt -async 1 -vcodec libx264 -bsf:a aac_adtstoasc $PROJDIR/forasecond.mp4
