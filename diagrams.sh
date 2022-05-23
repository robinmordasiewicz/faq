#!/bin/bash
#

if [ -f diagram.png ];then
  rm diagram.png
fi

python3 intro-diagram.py
