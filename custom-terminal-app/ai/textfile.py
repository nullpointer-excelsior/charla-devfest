from libs.chatgpt import ask_to_chatgpt
from libs.cli import userinput_argument, get_context_options
import click


PROMPT_BASE="""
En base al siguiente contenido encerrado en triple acento grave ```{content}``` responderás las preguntas del usuario. 
"""

@click.command(help='Pregunta a ChatGPT')
@click.pass_context
@click.argument('file', type=click.File('r'))
@click.option('-q', '--question', type=str, help="Proporciona una pregunta acerca del archivo")
def textfile(ctx, file, question):
    model, temperature = get_context_options(ctx)
    prompt = PROMPT_BASE.format(content=file.read())
    ask_to_chatgpt(question, prompt=prompt, model=model, temperature=temperature)
