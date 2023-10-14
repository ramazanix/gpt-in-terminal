import g4f


# streamed completion
response = g4f.ChatCompletion.create(
    model="gpt-3.5-turbo",
    messages=[{"role": "user", "content": input()}],
    stream=True,
)

for message in response:
    print(message, flush=True, end='')
print()

