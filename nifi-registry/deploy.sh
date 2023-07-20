#!/bin/bash

# Скрипт необходимо запустить через sudo

# TODO: Передать пароли через Docker секреты

read -p "Введите пароль от Java Keystore: " KEYSTOREPASS

if [[ -z "$KEYSTOREPASS" ]]; then
    echo "Пустой ввод, операция прервана"
    exit 1
fi

read -p "Введите пароль от Java Truststore: " TRUSTSTOREPASS

if [[ -z "$TRUSTSTOREPASS" ]]; then
    echo "Пустой ввод, операция прервана"
    exit 1
fi

docker run --rm -d \
    --name nifi-registry \
    --network northgatevologda \
    -v /opt/certs/nifi.northgatevologda.ru:/opt/certs \
    -h nifi.northgatevologda.ru \
    -p 18443:18443 \
    -e AUTH=tls \
    -e KEYSTORE_PATH=/opt/certs/keystore.jks \
    -e KEYSTORE_TYPE=JKS \
    -e KEYSTORE_PASSWORD=$KEYSTOREPASS \
    -e TRUSTSTORE_PATH=/opt/certs/truststore.jks \
    -e TRUSTSTORE_PASSWORD=$TRUSTSTOREPASS \
    -e TRUSTSTORE_TYPE=JKS \
    -e INITIAL_ADMIN_IDENTITY='CN=AdminUser, OU=nifi' \
    apache/nifi-registry:latest
