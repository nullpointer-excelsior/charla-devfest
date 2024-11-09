#!/bin/bash

#!/bin/bash

# Array de URLs para cada generación
urls=(
  "https://pokeapi.co/api/v2/pokemon?offset=0&limit=151"
  "https://pokeapi.co/api/v2/pokemon?offset=151&limit=100"
  "https://pokeapi.co/api/v2/pokemon?offset=251&limit=135"
  "https://pokeapi.co/api/v2/pokemon?offset=386&limit=107"
  "https://pokeapi.co/api/v2/pokemon?offset=493&limit=156"
  "https://pokeapi.co/api/v2/pokemon?offset=649&limit=72"
  "https://pokeapi.co/api/v2/pokemon?offset=721&limit=88"
  "https://pokeapi.co/api/v2/pokemon?offset=809&limit=96"
  "https://pokeapi.co/api/v2/pokemon?offset=905&limit=103"
)

# Función para descargar una generación
function download_generation() {
  local generation=$1
  local url=$2
  local filename="generation_${generation}.json"

  echo "Descargando generación $generation..."
  curl -s "$url" -o "$filename"
  echo "Generación $generation guardada en $filename"
}

# Descargar cada generación en paralelo
for i in "${!urls[@]}"; do
    generation=$((i + 1))
    download_generation "$generation" "${urls[$i]}" &
done
# Esperar a que terminen todos los procesos
wait

echo "Descarga de todas las generaciones completada."

