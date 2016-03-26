#!/bin/bash
RAWPATH=$1

#Convert and trim all raw clips
rm $RAWPATH/trimmed/*.ts

#Handle spaces in filenames
OIFS="$IFS"
IFS=$'\n'

for f in `ls -t $RAWPATH/*.{mov,MOV,mp4,MP4}`;
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
> input.txt

for f in `ls -1 $RAWPATH/trimmed/*_resized.ts`;
do
	echo "Including $f in list of files to concatenate"
	echo "file $f" >> input.txt
done

#ffmpeg -y -i "concat:$(ls -1 $RAWPATH/trimmed/*_resized.ts | perl -0pe 's/\n/|/g;s/\|$//g')" -async 1 -vcodec libx264 -bsf:a aac_adtstoasc $RAWPATH/../forasecond.mp4
ffmpeg -y -f concat -analyzeduration 100M -probesize 100M -i input.txt -async 1 -vcodec libx264 -bsf:a aac_adtstoasc $RAWPATH/../forasecond.mp4
#rm input.txt
