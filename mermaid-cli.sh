#!/bin/sh
#

if [ -e intro.png ];then
  rm intro.png
fi

/usr/local/bin/mmdc -p /puppeteer-config.json -i intro.mmd -o intro.png -C mermaid.css -c mermaid-config.json -t neutral

#-i intro.mmd -o intro.png -C mermaid.css -c mermaid-config.json -t neutral
