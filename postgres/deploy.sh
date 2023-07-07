#!/bin/bash

# Создаем необходимые директории
sudo mkdir /home/docker_volumes/
sudo mkdir /home/docker_volumes/pgadmin/
sudo mkdir /home/docker_volumes/pgdata/

# Выдаем права на директории
sudo chown -R 5050:5050 /home/docker_volumes/pgadmin/

# Читаем все секреты Docker
source ../secrets.sh

# Создаем стэк контейнеров
sudo docker stack deploy --compose-file docker-compose.yml dbstack