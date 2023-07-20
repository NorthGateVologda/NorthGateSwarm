#!/bin/bash

# Скрипт необходимо запустить через sudo

# Создём сеть
docker network create --driver overlay --attachable northgatevologda
