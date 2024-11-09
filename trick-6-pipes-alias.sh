#!/bin/bash

# los pipes nos ayudan a crear comandos mas complejos
cat *.json | jq -r '.results[].name' | grep -E '.*' | sort



# alias nos ayuda a simplificar los comandos complejos
alias bigfiles='find . -type f -exec du -h {} + | sort -hr | head -10'