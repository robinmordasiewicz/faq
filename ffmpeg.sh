#!/bin/bash
#

#ffmpeg -y -framerate .5 -i intro.png -c:v prores_ks -profile:v 2 -vendor apl0 -bits_per_mb 8000 -pix_fmt yuv422p10le -r 29.97 -s 1920x1080 -video_track_timescale 30000 intro.mov
#ffmpeg -y -i intro.mov -c copy -bsf:v prores_metadata=color_primaries=bt709:color_trc=bt709:colorspace=bt709 intro1.mov
#mv intro1.mov intro.mov

ffmpeg -y -framerate .5 -i intro.png -c:v h265 -pix_fmt yuv422p10le -r 29.97 -s 1920x1080 -video_track_timescale 30000 intro.mp4
exit 0

ffmpeg -y -framerate .5 -i outro.png -c:v prores_ks -profile:v 2 -vendor apl0 -bits_per_mb 8000 -pix_fmt yuv422p10le -r 29.97 -s 1920x1080 -video_track_timescale 30000 outro.mov
ffmpeg -y -i outro.mov -c copy -bsf:v prores_metadata=color_primaries=bt709:color_trc=bt709:colorspace=bt709 outro1.mov
mv outro1.mov outro.mov

exit 0
#ffmpeg -y -f concat -safe 0 -i videos.txt -filter_complex "gltransition=duration=4:offset=1.5" -pix_fmt yuv420p -c copy output.mov

#ffmpeg-concat -t circleopen -d 750 -o output2.mov intro.mov outro.mov

#ffmpeg -y -i intro.mov -i clip1.mov -i outro.mov -filter_complex "[0]settb=AVTB[v0];[1]settb=AVTB[v1];[0][v1]xfade=transition=fade:duration=1:offset=1,format=yuv420p" outputVideo.mov
#ffmpeg -y -i intro.mov -i clip1.mov -filter_complex "[0]settb=AVTB[v0];[1]settb=AVTB[v1];[v0][v1]xfade=duration=1:offset=1,format=yuv420p" outputVideo.mov

#ffmpeg -i intro.mov -i clip1.mov -filter_complex "[0:v]settb=AVTB,fps=30/1[v0];[1:v]settb=AVTB,fps=30/1[v1];[v0][v1]xfade=transition=fade:duration=1:offset=0,format=yuv420p" -c:v libx264 -t 10 -y outputVideo.mov
#ffmpeg -i outputVideo.mov -i outro.mov -filter_complex "[0:v]settb=AVTB,fps=30/1[v0];[1:v]settb=AVTB,fps=30/1[v1];[v0][v1]xfade=transition=fade:duration=1:offset=1,format=yuv420p" -c:v libx264 -t 10 -y outputVideo2.mov

ffmpeg -i intro1.mov -i clip1.mov -i outro1.mov -filter_complex \
"[0][1:v]xfade=transition=fade:duration=1:offset=3[vfade1]; \
 [vfade1][2:v]xfade=transition=fade:duration=1:offset=5,format=yuv420p; \
 [0:a][1:a]acrossfade=d=1[afade1]; \
 [afade1][2:a]acrossfade=d=1" \
-c:v prores_ks \
-profile:v 2 \
-vendor apl0 \
-movflags +faststart out4.mov
