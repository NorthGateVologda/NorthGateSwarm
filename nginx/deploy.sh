#!/bin/bash

# Скрипт необходимо запустить через sudo

# Создём сеть, если она не существует
docker network create --driver overlay --attachable northgatevologda

# Удаляем стек, если он существует
docker stack rm nginx

# Строим образ и деплоим стек
docker build -t ng_nginx:latest .
docker stack deploy --compose-file docker-compose.yml nginx

# В будущем нужно будет решить будем ли мы копировать конфигурацию или
# интегрировать её в образ
#docker cp defualt.conf \
#    $(docker ps --filter "name=nginx_nginx" -q):/etc/nginx/conf.d/
