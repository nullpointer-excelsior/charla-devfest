
from openai import OpenAI


chatgpt_models = {
    'gpt3': 'gpt-3.5-turbo',
    'gpt4': 'gpt-4',
    'gpt4t': 'gpt-4-turbo',
    'gpt4o': 'gpt-4o',
    'gpt4om': 'gpt-4o-mini'
}


def get_model(model: str):
    return chatgpt_models[model]


client = OpenAI()


def ask_to_chatgpt(
        userinput,
        model='gpt4om',
        temperature=0,
        prompt="Eres un util asistente. Responderas de forma directa y sin explicaciones",
    ):
    complete_response = ''
    messages = [
        {"role": "system", "content": prompt},
        {"role": "user", "content": userinput}
    ]
    stream = client.chat.completions.create(
        model=get_model(model),
        messages=messages,
        temperature=temperature,
        stream=True
    )
    for chunk in stream:
        delta = chunk.choices[0].delta
        answer = delta.content if delta.content is not None else ''
        print(answer, end="", flush=True)
        complete_response += answer
    print()
    return complete_response


def ask_simple_question_to_chatgpt(
        userinput,
        model='gpt4om',
        temperature=0,
    ):
    complete_response = ''
    messages = [
        {"role": "user", "content": userinput}
    ]
    stream = client.chat.completions.create(
        model=get_model(model),
        messages=messages,
        temperature=temperature,
        stream=True
    )
    for chunk in stream:
        delta = chunk.choices[0].delta
        answer = delta.content if delta.content is not None else ''
        print(answer, end="", flush=True)
        complete_response += answer
    print()
    return complete_response