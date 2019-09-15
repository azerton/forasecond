#!/bin/bash
PROJDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Move to the project parent folder
cd $PROJDIR

MOVPATH=$1

#Convert and trim all raw clips
mkdir $PROJDIR/tmp/trimmed
rm $PROJDIR/tmp/trimmed/*.ts

#Handle spaces in filenames
OIFS="$IFS"
IFS=$'\n'

for f in `find "$MOVPATH" -type f -name "*.mov" -o -name "*.MOV" -o -name "*.mp4" -o -name "*.MP4"`;
do
	echo "Processing $f"
	echo "Converting and trimming file format"
	./scripts/convert_format.sh "$f"
	#echo "Resizing clip"
	#./scripts/resize.sh "$f"
	echo ""
#	./scripts/timestamp.sh $f
done

#Now, multiplex all short clips together - overwrite the output file without asking for confirmation.
> $PROJDIR/tmp/input.txt

for f in `ls -1 $PROJDIR/tmp/trimmed/*.ts`;
do
	echo "Including $f in list of files to concatenate"
	echo "file $f" >> tmp/input.txt
done

ffmpeg -y -f concat -analyzeduration 100M -probesize 100M -safe 0 -i tmp/input.txt -async 1 -vcodec libx264 -bsf:a aac_adtstoasc $PROJDIR/forasecond.mp4
