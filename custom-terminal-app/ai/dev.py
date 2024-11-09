from libs.chatgpt import ask_to_chatgpt
from libs.cli import userinput_argument, get_context_options
import click


prompt="""
Eres un útil asistente y experto desarrollador y arquitecto de software. Responderás de forma directa y sin explicaciones.
"""

@click.command(help='Desarrollador experto')
@click.pass_context
@userinput_argument()
def dev(ctx, userinput):
    model, temperature = get_context_options(ctx)
    ask_to_chatgpt(userinput, prompt=prompt, model=model, temperature=temperature)
