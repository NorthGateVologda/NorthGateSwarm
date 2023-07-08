#!/bin/bash

# Создаём ворох папок для хранения данных
sudo mkdir /home/docker_volumes/certbot
sudo mkdir /home/docker_volumes/certbot/conf
sudo mkdir /home/docker_volumes/certbot/www
sudo mkdir /home/docker_volumes/certbot/conf/live/
sudo mkdir /home/docker_volumes/certbot/conf/live/northgatevologda.ru/ # adjust to your domain
sudo mkdir /home/docker_volumes/static
sudo mkdir /home/docker_volumes/media

# Создём сеть, если она не существует
sudo docker network create --driver overlay --attachable northgatevologda

# Удаляем стек и образ, если они существуют
sudo docker stack rm nginxstack
sudo docker image rm nginx:latest -f
sudo docker image rm certbot/certbot:latest -f

# Строим образ и создаём docker стек
sudo docker build -t nginx:latest .
sudo docker stack deploy --compose-file docker-compose.yml nginxstack
