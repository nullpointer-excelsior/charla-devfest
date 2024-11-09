import os
import click
import base64
from openai import OpenAI


client = OpenAI()


def openai_vision_request(model, user_input, base64_image):
    stream = client.chat.completions.create(
        model=model,
        messages=[
            {
            "role": "user",
            "content": [
                {
                    "type": "text", 
                    "text": user_input
                },
                {
                    "type": "image_url",
                    "image_url": {
                        "url": f"data:image/jpeg;base64,{base64_image}",
                    },
                },
            ],
            }
        ],
        max_tokens=1000,
        stream=True
    )
    for chunk in stream:
        delta = chunk.choices[0].delta
        answer = delta.content if delta.content is not None else ''
        yield answer


def capture_screen(filename):
    os.system(f"screencapture -i {filename}")


def png_to_base64(file_path):
    with open(file_path, 'rb') as image_file:
        image_data = image_file.read()
        base64_encoded = base64.b64encode(image_data)
        return base64_encoded.decode('utf-8')
    

def translate_image(model, base64_image):
    for stream in openai_vision_request(model, "Traduce el siguiente texto al español si el contenido esta en ingles y si el contenido esta en español traducelo al ingles", base64_image):
        print(stream, end="", flush=True)


def explain_image(model, base64_image):
    for stream in openai_vision_request(model, "Explicame que hay en la imagen", base64_image):
        print(stream, end="", flush=True)


def prompt_image(model, prompt, base64_image):
    for stream in openai_vision_request(model, prompt, base64_image):
        print(stream, end="", flush=True)

@click.command(help='Captura de pantalla con integración AI')
@click.option('-tr', '--translate', is_flag=True, help="Habilita la opción de traducción")
@click.option('-e', '--explain', is_flag=True, help="Habilita la opción de explicación")
@click.option('-p', '--prompt', type=str, help="Proporciona un prompt de texto")
def screenshot(translate, explain, prompt):
    filename = "capture.png"

    capture_screen(filename)
    b64 = png_to_base64(filename)
    
    if translate:
        translate_image('gpt-4o-mini', b64)
    if explain:
        explain_image('gpt-4o-mini', b64)
    if prompt:
        prompt_image('gpt-4o-mini', prompt, b64)
    
    os.system(f"rm -f {filename}")