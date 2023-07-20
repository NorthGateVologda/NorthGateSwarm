# Очень хорошо, что зафиксировали версию!
FROM python:3.9

ENV PYTHONUNBUFFERED 1

# Создаётся автоматом с командой WORKDIR
#RUN mkdir /backend

WORKDIR /backend

COPY prod.txt /backend/requirements/prod.txt

# Все RUN-ы лучше объединить в один через &&
# для экономии места. На каждый RUN создаётся Docker слой.
RUN apt-get update -y \
    && apt-get upgrade -y \
    && pip install --upgrade pip \
    && pip install -r requirements/prod.txt \
    && apt-get install -y gdal-bin libgdal-dev

CMD gunicorn -w 3 config.wsgi --bind 0.0.0.0:8000
