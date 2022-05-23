#!/usr/bin/env bash

set -x

COMMAND=(/bin/bash -c " -i intro.mmd -o intro.png -C mermaid.css -c mermaid-config.json -t neutral")

DOC_IMG="robinhoodis/mermaid-cli:latest"

exec docker run --rm -it \
  -v "$PWD":"/home/ubuntu" --workdir "/home/ubuntu" \
  ${DOCKER_RUN_ARGS} \
  ${DOC_IMG} "${COMMAND[@]}"
