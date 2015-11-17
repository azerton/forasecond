Scripts that convert a bunch of video files into one long movie of 1 second clips


## "offline" folder

All the offline files to generate the clip offline without interaction of the web server.

Running:
```
./forasecond.sh <folder where raw clips are stored>
```

The folder that contains the raw clips should contain 2 empty sub-folders: "trimmed" and "converted". The path provided as argument should also be a full system path, not a relative path. For example, this should work:

```
./forasecond.sh ~/Desktop/Projects/forasecond/offline/clips/
```