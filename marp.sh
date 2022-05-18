#!/bin/bash
#

# docker run --rm --init -v $PWD:/home/marp/app/ -e LANG=$LANG marpteam/marp-cli intro.md --pptx

marp intro.md --pptx
