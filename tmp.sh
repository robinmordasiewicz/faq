#ffmpeg -i intro.mov -i clip1.mov -i outro.mov -i clip1.mov -i outro.mov -filter_complex \
#"[0][1:v]xfade=transition=fade:duration=1:offset=3[vfade1]; \
# [vfade1][2:v]xfade=transition=fade:duration=1:offset=10[vfade2]; \
# [vfade2][3:v]xfade=transition=fade:duration=1:offset=21[vfade3]; \
# [vfade3][4:v]xfade=transition=fade:duration=1:offset=25,format=yuv420p; \
# [0:a][1:a]acrossfade=d=1[afade1]; \
# [afade1][2:a]acrossfade=d=1[afade2]; \
# [afade2][3:a]acrossfade=d=1[afade3]; \
# [afade3][4:a]acrossfade=d=1" \
#-movflags +faststart out.mp4


ffmpeg -i intro1.mov -i clip1.mov -i outro1.mov -filter_complex "[0:v][1:v]xfade=transition=fade:duration=1:offset=0,format=yuv420p" -c:v libx264 -t 10 -y out.mp4
