from libs.chatgpt import ask_to_chatgpt
from libs.cli import userinput_argument, get_context_options
import click


def get_instructions(words, sentences, tone, audience, style, markdown, translate):
    instructions = []
    if words:
        instructions.append(f' - El resumen no debe tener más de {words} palabras.')
    elif sentences:
        instructions.append(f' - El resumen no debe tener más de {sentences} oraciones.')
    if style:
        instructions.append(f' - El resumen debe tener un estilo {style}.')
    if audience:
        instructions.append(f' - El resumen debe apuntar a una audiencia {audience}.')
    if tone:
        instructions.append(f' - El resumen debe tener un tono {tone}.')
    if markdown:
        instructions.append(' - El resumen debe estar formato markdown.')
    if translate:
        instructions.append(' - El resumen debe ser traducido al español si es necesario.')
    return instructions


def get_prompt(text, instructions):
    if len(instructions) > 0:
        instructions_list = '\n'.join(instructions)
        instructions_text = f'El resumen debe seguir las siguientes instrucciones:\n{instructions_list}'
    else:
        instructions_text = ''
    return f"""Tu tarea sera resumir el texto encerrado en triple acento grave.\n{instructions_text}\n```{text}```."""


@click.command(help='Resume un texto')
@click.pass_context
@userinput_argument()
@click.option('--words', '-w', type=int, help='Número de palabras aproximadas', default=None)
@click.option('--sentences', '-s', type=int, help='Número de oraciones aproximadas', default=None)
@click.option('--tone', '-t', type=str, help='Tono del resumen', default=None)
@click.option('--audience', '-a', type=str, help='Público objetivo del resumen', default=None)
@click.option('--style', '-st', type=str, help='Estilo del resumen', default=None)
@click.option('--markdown', '-md', type=str, is_flag=True, help='Formato de salida mardown')
@click.option('--translate', '-tr', is_flag=True, help='Traduce si es necesario')
def summarize(ctx, userinput,words, sentences, tone, audience, style, markdown, translate):
    instructions = get_instructions(words, sentences, tone, audience, style, markdown, translate)
    prompt = get_prompt(userinput, instructions)
    model, temperature = get_context_options(ctx)
    ask_to_chatgpt(userinput, prompt=prompt, model=model, temperature=temperature)
