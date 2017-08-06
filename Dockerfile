FROM nginx:alpine

RUN mkdir /var/cache/nginx/client_temp && chgrp 0 /var/cache/nginx/client_tmp

USER default
