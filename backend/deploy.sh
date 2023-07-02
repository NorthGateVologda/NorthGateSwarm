#!/bin/bash

# Чтение пути от пользователя
echo "Введите путь к исходным файлам backend:"
read path

# Копируем исходные файлы
sudo cp -r $path docker-build-context
sudo cp Dockerfile docker-build-context

# Собираем образ
sudo docker build -t northgatebackend-backend:latest docker-build-context/

# Удаляем директорию
sudo rm -rf docker-build-context

# Читаем все секреты Docker
source ../secrets.sh

# Создаем стэк контейнеров
sudo docker stack deploy --compose-file docker-compose.yml backend