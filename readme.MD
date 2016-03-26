## What is this
Scripts that convert a bunch of video files into one long movie of 1 second clips


## Requirements

All the heavy lifting is done using ``ffmpeg``.
``ffmpeg`` should be invokable on the command line. You can test this as following:

```
fmpeg -version
```

## The "offline" folder

All the offline files to generate the clip offline without interaction of the web server.

Running the script:
```
./forasecond.sh <folder where raw clips are stored>
```

The folder that contains the raw MOV clips (extension .mov or .MOV) should contain 2 empty sub-folders: "trimmed" and "converted". The path provided as argument can be a relative path. For example, this should work:

```
./forasecond.sh ~/Desktop/Projects/forasecond/offline/clips/
```

Output of running the script should be a file called forasecond.mp4 in the "offline" folder.


## License
```
            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004

 Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>

 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. You just DO WHAT THE FUCK YOU WANT TO.
```

