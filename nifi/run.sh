#!/bin/bash

# Скрипт необходимо запустить через sudo

docker run --rm -d -p 8443:8443 \
    -h northgatevologda.ru \
    -v nifi_logs:/opt/nifi/nifi-current/logs \
    -v nifi_conf:/opt/nifi/nifi-current/conf \
    -v nifi_db:/opt/nifi/nifi-current/database_repository \
    -v nifi_flow:/opt/nifi/nifi-current/flowfile_repository \
    -v nifi_cont:/opt/nifi/nifi-current/content_repository \
    -v nifi_prov:/opt/nifi/nifi-current/provenance_repository \
    -v nifi_state:/opt/nifi/nifi-current/state \
    apache/nifi:1.21.0
# Старайтесь всегда виксировать версию!
# Через месяц в latest могут внести такие изменения, коорые погубят всё
# приложение и мы можем потратить очень много времени на поиск причины
