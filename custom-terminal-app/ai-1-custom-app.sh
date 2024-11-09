#!/bin/zsh

## click nos proporciona una manera sencilla de configurar la ayuda

# ayuda de la aplicacion
python ai --help

# ayuda de un comando especifico
python ai dev --help

# en base a prompt engineering podemos crear aplicaciones rapidas y utiles
python ai dev "como puedo buscar archivos python en el directorio actual en bash"

# las opciones nos dara control sobre el comportamiento de la applicacion
python ai -m gpt4o dev "como puedo buscar archivos python en el directorio actual en bash"

# traduccion sencilla
python ai translate "De paladin a hechizero como integrar bash con AI"

# traduccion basada en stdin
man cat | python ai translate

# pregunta a un archivo
python ai textfile ../pokemon-gen1.json -q "dame los primeros 5 pokemones de fuego del archivo"

# podemos hacer uso de la api avanzada de openia y funcionalidades del sistema operativo
python ai screenshot -p "que hay en la imagen"


