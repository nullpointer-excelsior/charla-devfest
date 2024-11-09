from libs.chatgpt import  ask_to_chatgpt
from libs.cli import userinput_argument, copy_option, get_context_options
import click
import pyperclip


PROMPT = """
Traduce el siguiente texto: "{text}"
Si el texto esta en inglés traducelo al español o viceversa.
"""


@click.command(help='Traductor de Inglés - Español')
@click.pass_context
@userinput_argument()
@copy_option()
def translate(ctx, userinput, copy):
    prompt = PROMPT.format(text=userinput)
    model, temperature = get_context_options(ctx)
    response = ask_to_chatgpt(userinput, prompt=prompt, model=model, temperature=temperature)
    if copy:
        pyperclip.copy(response) 

