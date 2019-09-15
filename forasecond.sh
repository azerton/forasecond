#!/bin/bash
PROJDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#Handle spaces in filenames
OIFS="$IFS"
IFS=$'\n'

# Move to the project parent folder
cd "$PROJDIR"
MOVPATH=$1

# Convert and trim all raw clips
mkdir "$PROJDIR/tmp/trimmed"
rm "$PROJDIR/tmp/trimmed/*.ts"

# Empty the file list
> $PROJDIR/tmp/input.txt

for f in `find "$MOVPATH" -type f -name "*.mov" -o -name "*.MOV" -o -name "*.mp4" -o -name "*.MP4"|xargs stat -f '%c %N'|sort|cut -d ' ' -f 2-`;
do
	echo "Processing $f"
	echo "Converting and trimming file format"

  OUTPUTDIR="$PROJDIR/tmp/trimmed"
  FILENAME=`basename "$f"`
  echo "Outputting converted file to $OUTPUTDIR"
  FILENAME_UNDERSCORED=`echo ${FILENAME// /_}`
  ffmpeg -y -i "$f" -ss 00:00:00 -t 00:00:01 -vf "scale=min(iw*720/ih\,1280):min(720\,ih*1280/iw),pad=1280:720:(1280-iw)/2:(720-ih)/2" -vcodec libx264 -acodec copy "$OUTPUTDIR/${FILENAME_UNDERSCORED}.ts";

  echo "Including $f in list of files to concatenate"

  echo "file $OUTPUTDIR/${FILENAME_UNDERSCORED}.ts" >> tmp/input.txt
	echo ""
#	./scripts/timestamp.sh $f
done

ffmpeg -y -f concat -analyzeduration 100M -probesize 100M -safe 0 -i tmp/input.txt -async 1 -vcodec libx264 -bsf:a aac_adtstoasc $PROJDIR/forasecond.mp4
