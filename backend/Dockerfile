# Очень хорошо, что зафиксировали версию!
FROM python:3.9

ENV PYTHONUNBUFFERED 1

RUN mkdir /backend

WORKDIR /backend

COPY . /backend

RUN apt-get update -y

RUN apt-get upgrade -y

RUN pip install --upgrade pip

RUN pip install -r requirements/prod.txt

RUN apt-get update && apt-get install -y \
    gdal-bin \
    libgdal-dev

CMD gunicorn -w 3 config.wsgi --bind 0.0.0.0:8000
