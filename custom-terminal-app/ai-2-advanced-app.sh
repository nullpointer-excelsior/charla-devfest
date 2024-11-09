#!/bin/zsh

# fabric es una herramienta avanzada y opensource
fabric --help

# los prompts son reunidos en patterns ya predefinidos
fabric -l

# uso de un pattern
pbpaste | fabric --pattern summarize

# usamos una caracteristica interesante con youtube
fabric -y "https://www.youtube.com/watch?v=v81EsjzxWFo&t=461s" --stream --pattern extract_wisdom -g es

# podemos modificar el comportamiento
fabric -y "https://www.youtube.com/watch?v=v81EsjzxWFo&t=461s" --stream --pattern tweet -g es