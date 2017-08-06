FROM nginx:alpine

RUN chgrp 0 /var/cache/nginx/client_temp

USER default
