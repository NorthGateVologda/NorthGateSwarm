#!/bin/bash

# Скрипт должен запускаться с sudo

# Чтение значений из файла .env в текущей директории
while IFS='=' read -r key value || [[ -n "$line" ]]; do
    # Пропускаем комментарии
    if [[ $key == '#'* ]]; then
        continue
    fi

    # Удаление лишних пробельных символов в ключе и значении
    key="${key// /}"
    value="${value// /}"

    # Логируем значение считанной переменной из .env файла
    echo "Значение переменной: $value"

    # Удаляем docker secret по имени
    docker secret rm "$key"

    # Создание Docker секрета
    echo "$value" | docker secret create "$key" -
done < secrets.env
