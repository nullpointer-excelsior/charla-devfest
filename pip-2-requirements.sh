#!/bin/bash

# Installs a python dependency and adds it to the requirements.txt file

dependency="$1"

pip install "$dependency"

version=$(pip freeze | grep -i "$dependency")

echo "version installed: $version"

if [ ! -f "requirements.txt" ]; then
  touch requirements.txt
fi

if ! grep -q "$dependency" requirements.txt; then
  echo "$version" >> requirements.txt 
fi