FROM nginx:alpine

RUN mkdir -p /var/cache/nginx/client_tmp && chgrp 0 /var/cache/nginx/client_tmp

USER default
