import click
from grammar import grammar
from dev import dev
from question import question
from translate import translate
from summarize import summarize
from english import english
from libs.cli import model_option, temperature_option
from screenshot import screenshot
from commit_generator import commit_generator
from explain_command import explain_command


@click.group(help='Herramientas de AI para terminal bash')
@model_option()
@temperature_option()
@click.pass_context
def cli(ctx, model, temperature):
    ctx.ensure_object(dict)
    ctx.obj['model'] = model
    ctx.obj['temperature'] = temperature

cli.add_command(question)
cli.add_command(grammar)
cli.add_command(translate)
cli.add_command(dev)
cli.add_command(english)
cli.add_command(summarize)
cli.add_command(screenshot)
cli.add_command(commit_generator)
cli.add_command(explain_command)

cli()