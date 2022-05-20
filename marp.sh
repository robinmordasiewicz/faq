#!/bin/bash
#

if test -f "/home/marp/.cli/docker-entrypoint"; then
    /home/marp/.cli/docker-entrypoint intro.md --theme marp-theme.css --allow-local-files --html
else
    marp intro.md --theme marp-theme.css --allow-local-files --html
fi

