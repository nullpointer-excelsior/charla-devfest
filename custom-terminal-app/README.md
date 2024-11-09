# Terminal App Example

Aplicaciones utilitarias para terminal

## Instalación

Activar ambiente virtual e instalar dependencias
```shell
source .venv/bin/activate
pip install -r requirements.txt
```

Agregar a `~/.zshrc` o `.bash_profile`

```shell
export OPENAI_API_KEY="XXX"
alias ai='${REPOSITORY_DIR}/.venv/bin/python ${REPOSITORY_DIR}/terminal-apps/ai'
```


## Ejecutar aplicaciones

```shell
#!/bin/bash

# aplicaciones con AI
python ai


```