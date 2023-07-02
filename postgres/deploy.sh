#!/bin/bash

# Создаем необходимые директории
sudo mkdir /home/docker_volumes/
sudo mkdir /home/docker_volumes/certs/
sudo mkdir /home/docker_volumes/pgadmin/
sudo mkdir /home/docker_volumes/pgdata/

# Генерируем сертификат
sudo openssl genrsa -out /home/docker_volumes/certs/server.key 2048
sudo openssl req -new -key /home/docker_volumes/certs/server.key -out /home/docker_volumes/certs/server.csr
sudo openssl x509 -req -days 365 -in /home/docker_volumes/certs/server.csr -signkey /home/docker_volumes/certs/server.key -out /home/docker_volumes/certs/server.crt

# Выдаем права на директории
sudo chown -R 5050:5050 /home/docker_volumes/certs/
sudo chown -R 5050:5050 /home/docker_volumes/pgadmin/

# Читаем все секреты Docker
source ../secrets.sh

# Создаем стэк контейнеров
sudo docker stack deploy --compose-file docker-compose.yml dbstack