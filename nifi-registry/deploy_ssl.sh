#!/bin/bash

# Скрипт необходимо запустить через sudo

# TODO: Передать пароли через Docker секреты
# TODO: реанимировать SSL конфигурацию, когда у нас будут коммерческие
# сертификаты, пока что этот скрипт не вызывается

if [[ -z "$1" ]]; then
    read -p "Введите пароль от Java Keystore: " KEYSTOREPASS
    if [[ -z "$KEYSTOREPASS" ]]; then
        echo "Пустой ввод, операция прервана"
        exit 1
    fi
else
    KEYSTOREPASS=$1
fi

if [[ -z "$2" ]]; then
    read -p "Введите пароль от Java Truststore: " TRUSTSTOREPASS
    if [[ -z "$TRUSTSTOREPASS" ]]; then
        echo "Пустой ввод, операция прервана"
        exit 1
    fi
else
    TRUSTSTOREPASS=$2
fi

docker run --rm -d \
    --name nifi-registry \
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

# TODO: настроить тома для логирования и конфигурации
#-v nifi-registry_logs:/opt/nifi-registry/nifi-registry-current/logs \
#-v nifi-registry_conf:/opt/nifi-registry/nifi-registry-current/conf \
