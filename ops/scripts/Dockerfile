# Dockerfile for launching the script containers.py
FROM docker:24-cli

# Install python3 and pip3
RUN apk add --no-cache python3 py3-pip

# Copiar el script Python al contenedor
COPY ./containers.py /containers.py

# Definir el punto de entrada del contenedor
ENTRYPOINT ["python3", "/containers.py"]
