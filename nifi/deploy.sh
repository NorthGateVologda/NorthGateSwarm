#!/bin/bash

# Создём сеть, если она не существует
sudo docker network create --driver overlay --attachable northgatevologda

# Удаляем стек
sudo docker stack rm nifistack

# Создаем необходимые директории
sudo mkdir /home/docker_volumes/nifi

# Создаем стэк контейнеров
sudo docker stack deploy --compose-file docker-compose.yml nifistack
