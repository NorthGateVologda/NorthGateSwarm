FROM python:3

ENV PYTHONUNBUFFERED 1

RUN mkdir /backend

WORKDIR /backend

COPY . /backend

RUN apt-get update && apt-get install -y \
    gdal-bin \
    libgdal-dev

RUN pip install -r requirements/prod.txt