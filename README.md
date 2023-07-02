## NorthGateSwarm

Здесь содержатся все необходимые файлы для разворачивания инфрастрктуры

Директории:
- [postgres](postgres/) директория содержит `docker-compose.yml` файл, который разворачивает кластер сервисов в сети `postgres` для обеспечения работоспособности `базы данных` и `веб интерфейса`
- [backend](backend/) директория содержит `docker-compose.yml` файл, который разворачивает кластер сервисов в сети `backend` для обеспечения работоспособности `backend-части`

## Инструкция
1. Необходимо создать в главной директории файл `.env` со всеми `Docker secrets`. Файл так и должен называться `.env`.
Пример `Docker secrets` в файле `.env`:
```text
DB_NAME=db
DB_USER=vasya
DB_PASSWORD=vasya123
PGADMIN_EMAIL=vasya@mail.ru
PGADMIN_PASSWORD=vasya123
```
2. Для разворачивания кластера сервисов необходимо запустить bash-скрипт с помощью команды:
```bash
bash deploy.sh
```
В каждой директории содержится свой bash-скрипт `deploy.sh`