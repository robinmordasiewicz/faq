#!/usr/bin/env bash

set -x

COMMAND=(/bin/sh -c "mmdc -p /puppeteer-config.json -i intro.mmd -o intro.png -C mermaid.css -c mermaid-config.json -t neutral")
DOC_IMG="robinhoodis/mermaid-cli:latest"

exec docker run --rm -it \
  -v "$PWD":"/home/ubuntu" --workdir "/home/ubuntu" \
  ${DOC_IMG} "${COMMAND[@]}"

COMMAND=(/bin/sh -c "python3 intro-diagram.py")
DOC_IMG="robinhoodis/diagrams:latest"

exec docker run --rm -it \
  -v "$PWD":"/home/ubuntu" --workdir "/home/ubuntu" \
  ${DOC_IMG} "${COMMAND[@]}"
