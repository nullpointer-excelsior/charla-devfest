#!/bin/bash

# podemos ejecutar sonidos
afplay /System/Library/Sounds/Glass.aiff

# los sonidos nos ayuda a enterarnos cuando un proceso largo termine
echo "starting fake task..." && sleep 3 && echo "fake task finished!!" && afplay /System/Library/Sounds/Glass.aiff