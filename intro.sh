#!/bin/bash
#

title="Cloud Native Functions"
caption="5G INFRASTRUCTURE FOUNDATIONAL TO SUCCESS"

source style.conf

convert 1920x1080-openslide.png -verbose -strip -resize 1920x1080 -quality 100 -density 72x72 -units pixelsperinch tmp.png

convert -font Arial -pointsize 118 -fill ${INTROTITLEFONTCOLOR} -annotate +72+535 "${title}" tmp.png title.png
convert -font Arial-Narrow-Bold -pointsize 48 -fill ${INTROCAPTIONFONTCOLOR} -annotate +72+638 "${caption}" title.png title-caption.png

convert title-caption.png f5-logo-rgb.png -gravity northeast -geometry 130x130+110+110 -composite intro.png
ffmpeg -y -framerate .5 -i intro.png -c:v libx264 -pix_fmt yuv420p -r 29.01 intro.mov

rm title-caption.png title.png tmp.png
