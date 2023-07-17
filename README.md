## NorthGateSwarm

Здесь содержатся все необходимые файлы для разворачивания инфрастрктуры

Директории:

- [backend](backend/) конфигурация `Docker` стека `backend`-а
- [frontend](frontend/) конфигурация `Docker` стека `frontend`-а
- [postgres](postgres/) конфигурация `Docker` стека для базы данных
- [nifi](nifi/) конфигурация `Docker` стека `Nifi`
- [nginx](nginx/) конфигурация `Docker` стека центрального прокси

## Содержание

- [NorthGateSwarm](#northgateswarm)
- [Содержание](#содержание)
- [Секреты](#секреты)
  - [Nginx](#nginx)
  - [Инициализация](#инициализация)
  - [Развёрстка](#развёрстка)

## Секреты

> TODO: актуализировать

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

### Nginx

Для сборки образа `nginx` вам будет необходимо добавить папку с сертификатами
Папка должны содержать список файлов без какой либо древовидной структуры.
В папке должны быть следующие файлы, где `*.pri.pem` это личные ключи, а
просто `*.pem` это сами сертификаты. На каждый домен должны быть пара файлов.
Пара файлов `northgate.ru` являются сертификатами клиента. Найти все
сертификаты вы сможете в *Хранилище*. Далее необходимый список:

* `northgatevologda.ru.pem`
* `northgatevologda.ru.pri.pem`
* `api.northgatevologda.ru.pem`
* `api.northgatevologda.ru.pri.pem`
* `db.northgatevologda.ru.pem`
* `db.northgatevologda.ru.pri.pem`
* `nifi.northgatevologda.ru.pem`
* `nifi.northgatevologda.ru.pri.pem`
* `pgadmin.northgatevologda.ru.pem`
* `pgadmin.northgatevologda.ru.pri.pem`

### Инициализация

Перед развёрсткой улья вам единоразово необходимо произвести инициализацию
среды. Для этого выполните скрипт `init.sh` в корне проекта.

### Развёрстка

Для разворачивания и удаления кластера сервисов в каждой папке а так же в
корне проекта имеются два скрипта `deploy.sh` и `undeploy.sh`. Вы можете
загрузить или удалить конкретный стек из его папки или все целиком из корня
проекта. Если у скриптов нет прав запуска, вам можно обойти это с помощью
вызова `bash` с параметром - именем скрипта. Например, из корня:

```sh
sudo bash deploy.sh
```
