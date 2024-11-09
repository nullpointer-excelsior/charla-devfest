import click
import pyperclip
from libs.cli import copy_option, userinput_argument, get_context_options
from libs.chatgpt import ask_to_chatgpt

PROMPT_BASE = """
Corrije gramaticalmente el siguiente texto encerrado en triple acento grave. ```{userinput}```, no debes devolver el texto con el triple acento grave.
"""

@click.command(help='Corrije la gramatica de un texto')
@click.pass_context
@userinput_argument()
@copy_option()
def grammar(ctx, userinput, copy):
    model, temperature = get_context_options(ctx)
    prompt = PROMPT_BASE.format(userinput=userinput)
    response = ask_to_chatgpt(userinput, prompt=prompt, model=model, temperature=temperature)
    if copy:
        pyperclip.copy(response)

