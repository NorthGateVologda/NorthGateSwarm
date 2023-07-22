#!/bin/bash

# Скрипт необходимо запустить через sudo

docker run --rm -d \
    --name nifi-registry \
    --network nifi \
    -h registry.northgatevologda.ru \
    -p 18080:18080 \
    -v /opt/nifi/NorthGateNifi:/opt/repo \
    -e NIFI_REGISTRY_FLOW_PROVIDER=git \
    -e NIFI_REGISTRY_FLOW_STORAGE_DIR=/opt/repo \
    apache/nifi-registry:1.21.0
