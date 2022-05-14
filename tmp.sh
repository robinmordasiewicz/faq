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



#ffmpeg -y -i output-mlt.mov -c:v libx265 -crf 23 -tag:v hvc1 -pix_fmt yuv420p -color_primaries 1 -color_trc 1 -colorspace 1 -r 29.97 -s 1920x1080 -acodec mp2 -ac 1 -movflags +faststart compressed.mp4
ffmpeg -y -i intro-shotcut.mov -c:v libx264 -crf 23 -tag:v hvc1 -pix_fmt yuv420p -r 29.97 -s 1920x1080 -acodec copy -ac 1 -movflags compressed.mp4

#ffmpeg -y -i output-mlt.mov -c:v libx265 -crf 23 -pix_fmt yuv420p -color_primaries 1 -color_trc 1 -colorspace 1 -r 29.97 -s 1920x1080 -movflags +faststart compressed.mp4
