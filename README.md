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
- [Сетевые порты](#сетевые-порты)
- [Сертификаты](#сертификаты)
- [Инициализация](#инициализация)
- [Секреты](#секреты)
- [Fronend](#fronend)
- [Backend](#backend)
- [База данных](#база-данных)
- [Nifi](#nifi)
- [Nginx](#nginx)
- [Развёрстка](#развёрстка)

> TODO: интегрировать репозитории frontend-а и backend-а в образы целевых
> Dockerfile-ов и настроить `CI` для автогенерации контейнера вокруг
> исходников. Скорее всего будет целесообразно раскидать Dockerfile-ы
> привязанные к конкретным репозитриям по этим репозиториям, тем самым
> облегчив настройку CI. В данном репозитории Swarm останутся только те
> Dockerfile-ы для которых нет отдельного репозитория и конфигурация стеков,
> или одного стека в виде docker-compose.yml

## Сетевые порты

Блокировка сетевых портов [происходит][1] на уровне хостинга.

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

Для фронтенда скачайте репозиторий с кодом в папку `/opt/frontend`. На данном
этапе вы можете сделать это с помощью `git clone`. Скопируйте из скаченного
проекта следующие файлы: `package.json` и `package-lock.json` в папку
`frontend/` в данном репозитории:

```sh
cp /opt/frontend/package.json .
cp /opt/frontend/package-lock.json .
```

Запустите сборку и загрузку: `sudo bash deploy.sh`.

> TODO: разобраться со следующим предупреждением во время сборки образа

```
npm notice
npm notice New minor version of npm available! 9.7.2 -> 9.8.0
npm notice Changelog: <https://github.com/npm/cli/releases/tag/v9.8.0>
npm notice Run `npm install -g npm@9.8.0` to update!
npm notice
```

## Backend

Здесь с помощью `docker-compose.yml` поднимается кластер сервисов `Docker`
для обеспечения работы backend на сервере.

При работе необходимо учесть то, что в `docker-compose.yml` используются
`Docker secrets`, о чём описано выше.

Важно, для успешного развертывания необходимо иметь локальный образ
`backend`-а с названием `nf_backend`.

Скачайте репозиторий с кодом в папку `/opt/backend`. На данном
этапе вы можете сделать это с помощью `git clone`. Скопируйте из скаченного
проекта файл `requirements/prod.txt` в папку `backend/` в данном репозитории.

```sh
cp /opt/backend/requirements/prod.txt .
```

> TODO: разобраться со следующим предупреждением во время сборки образа

```
debconf: delaying package configuration, since apt-utils is not installed
```

```
WARNING: Running pip as the 'root' user can result in broken permissions and
conflicting behaviour with the system package manager. It is recommended to
use a virtual environment instead: https://pip.pypa.io/warnings/venv
```

Запустите сборку и загрузку: `sudo bash deploy.sh`.

## База данных

Здесь с помощью `docker-compose.yml` поднимается кластер сервисов `Docker`
для обеспечения работы базы данных на сервере.

При работе необходимо учесть то, что в `docker-compose.yml` используются
`Docker secrets`, о чём описано выше.

Также не забудьте создать необходимые директории для привязки постоянного
хранилища к `Docker`. Все необходимые команды прописаны в
[EnvironmentWiki][2]

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

Обратите особое внимание. Мы записываем конфигурацию `default.conf` при сборке
образа, но в тоже время папка `/etc/nginx/conf.d` определена как том
`Docker`-а. Сшштветственно при изменении `default.conf` в рамках проета `Swarm`
вам необходимо удалить том. В дальнейшем вы можете вносить временные изменнеия
через том:

```sh
VFMT='{{ .Mountpoint }}'
NGINX_CONT=$(sudo docker ps --filter "name=nginx_nginx" -q)
NGINX_VOLUME=$(sudo docker volume inspect --format "${VFMT}" nginx_config)
sudo vim $NGINX_VOLUME/default.conf
sudo docker exec -it $NGINX_CONT /bin/bash
nginx -s reload
```

Для удаления тома:

```sh
sudo docker volume rm nginx_config
```

> TODO: в будущем решить: оставить конфигурацию как том, и копировать её в
> контейнер через `docker cp` или же интегрировать её со сбокой образа и
> отключить том `Docker`-а

## Развёрстка

Для разворачивания и удаления кластера сервисов в большинстве папок имеются
`deploy.sh` и `undeploy.sh`. Вы можете загрузить или удалить конкретный стек
из его папки. Если у скриптов нет прав запуска, вам можно обойти это с помощью
вызова `bash` с параметром - именем скрипта: `sudo bash deploy.sh`.

Сисадмину рекомендуется создать следующие `alias`-ы для автоматизации
процесса развёрстки и мониторинга. `alias` развёрстки нужно запускать из
целевых папок:

* `alias deploy='sudo bash deploy.sh'`
* `alias undeploy='sudo bash undeploy.sh'`
* `alias dockerlog='sudo tail -f /var/log/messages | grep docker'`
* `alias niflg='sudo ls /var/lib/docker/volumes/nifi_logs/_data/nifi-app.log'`

Общие скрипты `deploy.sh` и `undeploy.sh` были удалены из корня проекта, так
как не все сервисы поднимаются в рамках *Улья*. `Nifi` поднимается с помощью
скрипта `run.sh` а удаляется из памяти в ручную.

[1]: https://mcs.mail.ru/app/mcs5568309969/services/infra/firewall
[2]: https://github.com/NorthGateVologda/NorthGateWiki/blob/main/ENVIRONMENT.md
