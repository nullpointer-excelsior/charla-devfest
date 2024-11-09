#!/bin/bash

# podemos usar el clipboard

curl "https://pokeapi.co/api/v2/pokemon?limit=150" | pbcopy

pbpaste > pokemon-gen1.json

cat pokemon-gen1.json