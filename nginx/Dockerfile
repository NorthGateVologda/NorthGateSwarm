# Старайтесь всегда виксировать версию!
# Через месяц в latest могут внести такие изменения, коорые погубят всё
# приложение и мы можем потратить очень много времени на поиск причины
FROM nginx:1.25.1

COPY options-ssl-nginx.conf \
        ssl-dhparams.pem \
        default.conf \
        certs/ \
        /etc/nginx/conf.d/
