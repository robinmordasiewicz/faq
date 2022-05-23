#!/bin/bash
#

exec docker run --rm -it -v "$PWD":"/home/ubuntu" --workdir "/home/ubuntu" robinhoodis/mermaid-cli:latest '(/bin/sh -c "mmdc -p /puppeteer-config.json -i intro.mmd -o intro.png -C mermaid.css -c mermaid-config.json -t neutral")'

exec docker run --rm -it -v "$PWD":"/home/ubuntu" --workdir "/home/ubuntu" robinhoodis/diagrams:latest "python3 intro-diagram.py"
