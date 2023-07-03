#!/bin/bash

read -p "Все файлы в директории /home/docker_volumes/frotnend будут удалены. Вы хотите продолжить? (y/n): " response

if [[ $response =~ ^[Yy]$ ]]; then
    # Создаём директорию для хранения данных
    sudo mkdir /home/docker_volumes/frontend
    sudo rm -r /home/docker_volumes/frontend/*

    # Чтение пути от пользователя
    echo "Введите путь к исходным файлам frontend:"
    read path

    # Удаляем образ, если он есть
    sudo docker stack rm frontend
    sudo docker image rm northgatefrontend-frontend:latest -f

    # Копируем исходные файлы
    sudo cp -r $path/* /home/docker_volumes/frontend/
    sudo cp Dockerfile /home/docker_volumes/frontend/

    # Собираем образ
    sudo docker build -t northgatefrontend-frontend:latest /home/docker_volumes/frontend

    # Читаем все секреты Docker
    source ../secrets.sh

    # Создаем стэк контейнеров
    sudo docker stack deploy --compose-file docker-compose.yml frontend
else
    echo "Операция отменена."
fi