#!/bin/bash

read -p "Все файлы в директории /home/docker_volumes/backend будут удалены. Вы хотите продолжить? (y/n): " response

if [[ $response =~ ^[Yy]$ ]]; then

    # Создём сеть, если она не существует
    sudo docker network create --driver overlay --attachable northgatevologda

    echo "Создаём папку по пути /home/docker_volumes/backend"

    # Создаём директорию для хранения данных
    sudo mkdir /home/docker_volumes/backend

    echo "Удаляем всё содержимое в папке по пути /home/docker_volumes/backend"

    sudo rm -r /home/docker_volumes/backend/*

    # Чтение пути от пользователя
    echo "Введите путь к исходным файлам backend:"
    read path

    echo "Удаляем стек backend и образ northgatebackend-backend:latest"

    # Удаляем образ, если он есть
    sudo docker stack rm backendstack

    echo "Копируем проект и Dockerfile в /home/docker_volumes/backend/"

    # Копируем исходные файлы
    sudo cp -r $path/* /home/docker_volumes/backend/
    sudo cp Dockerfile /home/docker_volumes/backend/

    # Собираем образ
    sudo docker build -t northgatebackend-backend:latest /home/docker_volumes/backend

    # Читаем все секреты Docker
    source ../secrets.sh

    # Создаем стэк контейнеров
    sudo docker stack deploy --compose-file docker-compose.yml backendstack
else
    echo "Операция отменена."
fi
