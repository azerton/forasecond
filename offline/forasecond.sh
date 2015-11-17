#!/bin/bash
RAWPATH=$1

#Convert and trim all raw clips
rm $RAWPATH/trimmed/*.ts

#Handle spaces in filenames
OIFS="$IFS"
IFS=$'\n'

for f in `ls -t $RAWPATH/*.{mov,MOV}`;
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
ffmpeg -y -i "concat:$(ls -1 $RAWPATH/trimmed/*_resized.ts | perl -0pe 's/\n/|/g;s/\|$//g')" -async 1 -vcodec libx264 -bsf:a aac_adtstoasc $RAWPATH/../forasecond.mp4
