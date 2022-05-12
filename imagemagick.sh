#!/bin/bash
#

title="Service Proxy for K8S"
caption="Service Provider Protocols"
INTROTITLEFONTCOLOR="#FFFFFF"
INTROCAPTIONFONTCOLOR="#FFFFFF"

convert 1920x1080-openslide.png -verbose -strip -resize 1920x1080 -quality 100 -density 72x72 -units pixelsperinch tmp.png

convert -font Arial -pointsize 118 -fill ${INTROTITLEFONTCOLOR} -annotate +72+535 "${title}" tmp.png title.png
convert -font Arial-Narrow-Bold -pointsize 48 -fill ${INTROCAPTIONFONTCOLOR} -annotate +72+638 "${caption}" title.png title-caption.png

convert title-caption.png f5-logo-rgb.png -gravity northeast -geometry 130x130+110+110 -composite intro.png

rm title-caption.png title.png tmp.png
