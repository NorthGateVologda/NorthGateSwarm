#!/bin/bash

# Скрипт необходимо запустить через sudo

# Собираем образ и деплоим стек
# Префикс ng_* в данном случае - NorthGate
docker build -t ng_nginx:latest .
docker stack deploy --compose-file docker-compose.yml nginx

# В будущем нужно будет решить будем ли мы копировать конфигурацию или
# интегрировать её в образ
#docker cp defualt.conf \
#    $(docker ps --filter "name=nginx_nginx" -q):/etc/nginx/conf.d/
