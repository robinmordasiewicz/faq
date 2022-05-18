#!/bin/bash
#

if test -f "/home/marp/.cli/docker-entrypoint"; then
    /home/marp/.cli/docker-entrypoint intro.md --pptx
else
    marp intro.md --pptx
fi
