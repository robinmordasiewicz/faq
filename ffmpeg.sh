#!/bin/bash
#

ffmpeg -y -framerate .5 -i intro.png -c:v libx264 -pix_fmt yuv420p -r 29.01 intro.mov
ffmpeg -y -framerate .5 -i outro.png -c:v libx264 -pix_fmt yuv420p -r 29.01 outro.mov

#ffmpeg -y -f concat -safe 0 -i videos.txt -filter_complex "gltransition=duration=4:offset=1.5" -pix_fmt yuv420p -c copy output.mov

ffmpeg-concat -t circleopen -d 750 -o output2.mov intro.mov outro.mov

ffmpeg \
-pix_fmt yuv420p \
-i intro.mov \
-i outro.mov \
-filter_complex xfade=transition=fade:\
duration=1:\
offset=0 \
outputVideo.mov

