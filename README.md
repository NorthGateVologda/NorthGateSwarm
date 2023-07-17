## NorthGateSwarm

Здесь содержатся все необходимые файлы для разворачивания инфрастрктуры

Директории:
- [postgres](postgres/) конфигурация `Docker` стека для базы данных
- [backend](backend/) конфигурация `Docker` стека `backend`-а
- [nginx](nginx/) конфигурация `Docker` стека центрального прокси
- [nifi](nifi/) конфигурация `Docker` стека Nifi

## Инструкция

Необходимо создать в главной директории файл `.env` со всеми `Docker secrets`.
Файл так и должен называться `.env`.

Пример `Docker secrets` в файле `.env`:

```text
DB_NAME=db
DB_USER=vasya
DB_PASSWORD=vasya123
PGADMIN_EMAIL=vasya@mail.ru
PGADMIN_PASSWORD=vasya123
```

Для разворачивания кластера сервисов необходимо запустить bash-скрипт с
помощью команды:

```bash
bash deploy.sh
```

В каждой директории содержится свой bash-скрипт `deploy.sh`
