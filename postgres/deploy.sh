#!/bin/bash

# Скрипт необходимо запустить через sudo

# Создаем стэк контейнеров
sudo docker stack deploy --compose-file docker-compose.yml db
