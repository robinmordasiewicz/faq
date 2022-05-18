#!/bin/bash
#

# docker run --rm --init -v $PWD:/home/marp/app/ -e LANG=$LANG marpteam/marp-cli intro.md --pptx
#which marp
#find / | grep marp
#marp-cli intro.md --pptx
id
ls -al

/home/marp/.cli/docker-entrypoint intro.md --pptx
