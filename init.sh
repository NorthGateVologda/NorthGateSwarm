#!/bin/bash

# Скрипт необходимо запустить через sudo

# Создём сеть основного стека
docker network create --driver overlay --attachable northgatevologda

# Создаём сеть для стека Nifi
docker network create nifi
