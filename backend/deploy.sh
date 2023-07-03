#!/bin/bash

read -p "Все файлы в директории /home/docker_volumes/backend будут удалены. Вы хотите продолжить? (y/n): " response

if [[ $response =~ ^[Yy]$ ]]; then
    # Создаём директорию для хранения данных
    sudo mkdir /home/docker_volumes/backend
    sudo rm -r /home/docker_volumes/backend/*

    # Чтение пути от пользователя
    echo "Введите путь к исходным файлам backend:"
    read path

    # Удаляем образ, если он есть
    sudo docker stack rm backend
    sudo docker image rm northgatebackend-backend:latest -f

    # Копируем исходные файлы
    sudo cp -r $path/* /home/docker_volumes/backend/
    sudo cp Dockerfile /home/docker_volumes/backend/

    # Собираем образ
    sudo docker build -t northgatebackend-backend:latest /home/docker_volumes/backend

    # Читаем все секреты Docker
    source ../secrets.sh

    # Создаем стэк контейнеров
    sudo docker stack deploy --compose-file docker-compose.yml backend
else
    echo "Операция отменена."
fi