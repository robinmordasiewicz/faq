#!/usr/bin/env bash

set -x

#COMMAND=(/bin/bash -c "mmdc -p /puppeteer-config.json -i intro.mmd -o intro.png -C mermaid.css -c config.json -t neutral")
COMMAND=(/bin/sh -c "/bin/sh")

DOC_IMG="robinhoodis/mermaid-cli:latest"
#DOC_IMG="minlag/mermaid-cli:latest"

exec docker run --rm -it \
  -v "$PWD":"/data" --workdir "/home/ubuntu" \
  ${DOC_IMG} "${COMMAND[@]}"
