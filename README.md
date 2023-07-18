## NorthGateSwarm

Здесь содержатся все необходимые файлы для разворачивания инфрастрктуры

Директории:

- [backend](backend/) конфигурация `Docker` стека `backend`-а
- [frontend](frontend/) конфигурация `Docker` стека `frontend`-а
- [postgres](postgres/) конфигурация `Docker` стека для базы данных
- [nifi](nifi/) конфигурация `Docker` стека `Nifi`
- [nginx](nginx/) конфигурация `Docker` стека центрального прокси

> TODO: подумать над тем, чтобы все сервисы объединить в один стек,
> папки при этом можно оставить. В каждой папке будет свой Dockerfile
> но docker-compose.yml будет один

## Содержание

- [NorthGateSwarm](#northgateswarm)
- [Содержание](#содержание)
- [Сертификаты](#сертификаты)
- [Инициализация](#инициализация)
- [Секреты](#секреты)
- [Fronend](#fronend)
- [Nifi](#nifi)
- [Nginx](#nginx)
- [Развёрстка](#развёрстка)

## Сертификаты

> TODO: вернуть интеграцию с certbot и заполнить главу

## Инициализация

Перед развёрсткой улья вам единоразово необходимо произвести инициализацию
среды. Для этого выполните скрипт `init.sh` в корне проекта. На данный момент
скрипт конфигурирует сеть.

## Секреты

Необходимо создать в главной директории файл `secrets.env` со всеми
`Docker` секретами.

Пример `Docker secrets` в файле `secrets.env`:

```text
DB_NAME=db
DB_USER=vasya
DB_PASSWORD=vasya123
PGADMIN_EMAIL=vasya@mail.ru
PGADMIN_PASSWORD=vasya123
```

Затем запустите файл `secrets.sh` с `sudo` и скоре всего передав как
параметр команде `bash`: `sudo bash secrets.sh`

## Fronend

Для фронтенда скачайте репозиторий с кодом в папку `/opt/frontend`

> TODO: интегрировать репозиторий в образ Docker-а и настроить `CI` для
> автогенерации контейнера вокруг исходников

## Nifi

В идеале нам будет необходимо поднять `Nifi` в рамках `Ngnix` со всеми
необходимыми сертификатами. Но на данный момент на это нет ресурсов времени,
по сему было решено поднять `Nifi` отдельно от *Улья*. `Nifi` в виде
контейнера `apache/nifi:1.22.0` в своей базовой конфигурации для полноценного
механизма аутентификации требует `TLS`. `TLS` настроен в виде самоподписанного
сертификата и экспортируется через порт `8443`. `Docker Swarm` не в состоянии
переварить такую настройку. Скорее всего в свете ограничений накладываемых
механизмами безопасности. Отказаться от `TLS` используя `NIFI_WEB_HTTP_PORT`,
как уже было сказанно, не целессобразно, так как `Nifi` будучи в публичном
доступе может стать целью злоумышлеников.

По сему мы решили запускать `Nifi` через команду `docker run -d`. Сделать это
можно с помощью команды `run.sh` в папке `nifi`.

> TODO: настроить пользователей, а так же реестр `Nifi`
> для сохранения схем в репозитории.
> TODO: интегрировать Nifi в лющий стек

## Nginx

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

> TODO: реанимировать все настройки, пока работает только fronend

## Развёрстка

Для разворачивания и удаления кластера сервисов в большинстве папок имеются
`deploy.sh` и `undeploy.sh`. Вы можете загрузить или удалить конкретный стек
из его папки. Если у скриптов нет прав запуска, вам можно обойти это с помощью
вызова `bash` с параметром - именем скрипта: `sudo bash deploy.sh`.

Сисадмину рекомендуется создать следующие `alias`-ы для автоматизации
процесса. `alias` нужно запускать из целевых папок:

* `alias deploy='sudo bash deploy.sh'`
* `alias undeploy='sudo bash undeploy.sh'`

Общие скрипты `deploy.sh` и `undeploy.sh` были удалены из корня проекта, так
как не все сервисы поднимаются в рамках *Улья*. `Nifi` поднимается с помощью
скрипта `run.sh` а удаляется из памяти в ручную.
