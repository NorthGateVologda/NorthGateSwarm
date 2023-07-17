#!/bin/bash

# Скрипт необходимо запустить через sudo

# Создаем стэк контейнеров
docker stack deploy --compose-file docker-compose.yml nifi
