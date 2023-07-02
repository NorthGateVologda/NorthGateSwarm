#!/bin/bash

# Чтение значений из файла .env в текущей директории
while read -r line || [[ -n "$line" ]]; do
    # Разделение строки на имя переменной и значение
    IFS='=' read -r -a parts <<< "$line"
    key="${parts[0]}"
    value="${parts[1]}"
    
    # Логируем значение считанной переменной из .env файла
    echo "Значение переменной: $value"

    # Удаляем docker secret по имени
    sudo docker secret rm "$key"

    # Создание Docker секрета
    echo "$value" | sudo docker secret create "$key" -
done < ../.env