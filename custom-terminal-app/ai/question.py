from libs.chatgpt import ask_to_chatgpt
from libs.cli import userinput_argument, get_context_options
import click


prompt="""
Eres un útil asistente. Responderás de forma directa y sin explicaciones a menos que te indique lo contrario.
"""

@click.command(help='Pregunta a ChatGPT')
@click.pass_context
@userinput_argument()
def question(ctx, userinput):
    model, temperature = get_context_options(ctx)
    ask_to_chatgpt(userinput, prompt=prompt, model=model, temperature=temperature)
