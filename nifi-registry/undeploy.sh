#!/bin/bash

# Скрипт необходимо запустить через sudo

docker stop nifi-registry

# TODO: проверить всегда ли удаляется контейнер при команде stop, или
# требуется ещё выполнить:
#docker rm nifi-registry
# UPD: скорее всего он сам удаляется за счёт опции --rm в команде docker run
