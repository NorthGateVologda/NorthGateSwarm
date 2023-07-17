#!/bin/bash

# Скрипт должен запускаться с sudo

# Запускаем в определенном порядке все
#sudo docker stack deploy --compose-file nginx/docker-compose.yml nginx
#sudo docker stack deploy --compose-file postgres/docker-compose.yml db
#sudo docker stack deploy --compose-file backend/docker-compose.yml backend
#sudo docker stack deploy --compose-file frontend/docker-compose.yml frontend

nginx/deploy.sh
