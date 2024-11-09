#!/bin/bash

# podemos ejecutar sonidos
afplay /System/Library/Sounds/Glass.aiff

alias play-glass='afplay /System/Library/Sounds/Glass.aiff'

echo "starting fake task..." && sleep 3 && echo "fake task finished!!" && afplay /System/Library/Sounds/Glass.aiff