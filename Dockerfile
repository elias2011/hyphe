FROM python:2.7

WORKDIR /app

ENV PYTHONPATH $PYTHONPATH:/app
ENV HYPHE_MS_LUCENE_ROOTPATH /app/lucene-data 

RUN apt-get update && apt-get install openjdk-7-jdk -y --no-install-recommends

COPY requirements.txt /app/requirements.txt

RUN pip install --requirement /app/requirements.txt \
    && pip install Scrapy==0.24.6 
 
COPY ./bin /app/bin
COPY ./config /app/config
COPY ./hyphe_backend /app/hyphe_backend

COPY ./memory_structure/memorystructure/ /app/hyphe_backend/memorystructure
COPY ./memory_structure/target/MemoryStructureExecutable.jar /app/hyphe_backend/memorystructure/

COPY ./docker-entrypoint.py /app/docker-entrypoint.py

RUN cp /app/config/config.json.example /app/config/config.json

RUN chmod +x /app/docker-entrypoint.py

EXPOSE 6978

VOLUME ["/app/config"]
VOLUME ["/app/lucene-data"]

ENTRYPOINT ["/app/docker-entrypoint.py"]
