FROM nginx:1.25.1

COPY options-ssl-nginx.conf \
        ssl-dhparams.pem \
        default.conf \
        certs/ \
        /etc/nginx/conf.d/
