#!/bin/zsh

# fabric es una herramienta avanzada y opensource
fabric --help

# los prompts son reunidos en patterns ya predefinidos
fabric -l

# uso de un pattern
cat pokemon-tale.txt | fabric --pattern summarize --language es --stream

# variedad de opciones nos permite una experiencia llena de creatividad con ia
cat pokemon-tale.txt | fabric --pattern analyze_personality --language es --stream

# pipes nos permite tareas complejas
cat pokemon-tale.txt | fabric --pattern analyze_personality --language es | python ai translate

# usamos una caracteristica interesante con youtube
fabric -y "https://www.youtube.com/watch?v=v81EsjzxWFo&t=461s" --stream --pattern extract_wisdom -g es

# podemos modificar el comportamiento
fabric -y "https://www.youtube.com/watch?v=v81EsjzxWFo&t=461s" --stream --pattern tweet -g es