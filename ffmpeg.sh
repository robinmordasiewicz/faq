#!/bin/bash
#

ffmpeg -y -framerate .5 -i intro.png -c:v libx264 -pix_fmt yuv420p -r 29.01 intro.mov

