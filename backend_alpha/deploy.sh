#!/bin/bash

# Скрипт необходимо запустить через sudo

# Деплоим стек в контур альфа
# Префикс ng_* в данном случае - NorthGate
docker stack deploy --compose-file docker-compose.yml backend_alpha
