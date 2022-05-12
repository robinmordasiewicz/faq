#!/bin/bash
#

title="Title layout:"
caption="Solid color option"
presenter="Presenter Name"
position="Position"
date="Date"
BACKGROUNDCOLOR="#05335C"
INTROTITLEFONTCOLOR="#FFFFFF"
INTROCAPTIONFONTCOLOR="#FFFFFF"
LOGO=f5-logo-white.png
BACKGROUND="1920x1080-openslide.png"
#BACKGROUND="corporate-template.png"

convert ${BACKGROUND} -verbose -strip -resize 1920x1080 -quality 100 -density 72x72 -units pixelsperinch tmp.png

convert -font Arial-Bold -pointsize 96 -fill ${INTROTITLEFONTCOLOR} -annotate +72+445 "${title}" tmp.png title.png
convert -font Arial-Bold -pointsize 96 -fill ${INTROCAPTIONFONTCOLOR} -annotate +72+543 "${caption}" title.png title-caption.png
convert -font Arial-Bold -pointsize 31 -fill ${INTROCAPTIONFONTCOLOR} -annotate +72+660 "${presenter}" title-caption.png title-caption-presenter.png
convert -font Arial-Bold -pointsize 31 -fill ${INTROCAPTIONFONTCOLOR} -annotate +72+728 "${position}" title-caption-presenter.png title-caption-presenter-position.png
convert -font Arial-Bold -pointsize 31 -fill ${INTROCAPTIONFONTCOLOR} -annotate +72+863 "${date}" title-caption-presenter-position.png title-caption-presenter-position-date.png

#convert title-caption-presenter-position-date.png ${LOGO} -gravity northeast -geometry 130x130+110+110 -composite intro.png
convert title-caption-presenter-position-date.png ${LOGO} -gravity northwest -geometry 95x95+75+75 -composite intro.png

rm title-caption.png title.png tmp.png title-caption-presenter.png title-caption-presenter-position.png title-caption-presenter-position-date.png
