#!/bin/bash

# Читаем все секреты Docker
source ../secrets.sh

# Создаем стэк контейнеров
sudo docker stack deploy --compose-file docker-compose.yml backend