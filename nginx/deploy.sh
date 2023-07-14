#!/bin/bash

# Создаём ворох папок для хранения данных
sudo mkdir /home/docker_volumes/certbot
sudo mkdir /home/docker_volumes/certbot/conf
sudo mkdir /home/docker_volumes/certbot/www
sudo mkdir /home/docker_volumes/certbot/conf/live/
sudo mkdir /home/docker_volumes/certbot/conf/live/northgatevologda.ru/ # adjust to your domain
sudo mkdir /home/docker_volumes/certbot/conf/live/api.northgatevologda.ru/
sudo mkdir /home/docker_volumes/certbot/conf/live/db.northgatevologda.ru/
sudo mkdir /home/docker_volumes/certbot/conf/live/pgadmin.northgatevologda.ru/
sudo mkdir /home/docker_volumes/certbot/conf/live/nifi.northgatevologda.ru/
sudo mkdir /home/docker_volumes/static
sudo mkdir /home/docker_volumes/media

# Создём сеть, если она не существует
sudo docker network create --driver overlay --attachable northgatevologda

# Удаляем стек, если он существует
sudo docker stack rm nginxstack

# Строим образ и создаём docker стек
sudo docker build -t nginx:latest .
sudo docker stack deploy --compose-file docker-compose.yml nginxstack
