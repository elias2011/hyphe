FROM python:2.7

WORKDIR /app

# Install system dependencies

RUN apt-get update && apt-get install openjdk-7-jdk -y --no-install-recommends


# App python dependencies

RUN "pip install -r requirements.txt"


# Install app

COPY ./bin /app/bin
COPY ./config /app/config
COPY ./hyphe_backend /app/hyphe_backend

#RUN sed "s|##HYPHEPATH##|"`pwd`"|" /app/config/config.json.example | sed 's|"OPEN_CORS_API": false,|"OPEN_CORS_API": true,|' > /app/config/config.json \
RUN mkdir -p /app/hyphe_backend/crawler/config \
  && cp /app/config/config.json /app/hyphe_backend/crawler/config/config.json


# Start hyphe

EXPOSE 6978

CMD /bin/bash -c "twistd -y /app/hyphe_backend/core.tac --nodaemon --pidfile="
