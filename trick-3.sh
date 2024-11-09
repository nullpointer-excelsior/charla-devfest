#!/bin/bash

# podemos recuperarnos de un comando fallido y ejecutar lo que queramos

cat generation_1.json || echo "no existe el archivo"
cat success.json || echo "no existe el archivo"
cat success.json 2&>/dev/null || echo "no existe el archivo"