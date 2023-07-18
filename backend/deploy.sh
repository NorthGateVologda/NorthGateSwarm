#!/bin/bash

# Скрипт необходимо запустить через sudo

# Собираем образ и деплоим стек
# Префикс ng_* в данном случае - NorthGate
docker build -t ng_backend:latest .
docker stack deploy --compose-file docker-compose.yml backend
