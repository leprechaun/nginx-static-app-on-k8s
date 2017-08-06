FROM nginx:alpine

RUN mkdir -p /var/cache/nginx/client_temp && chgrp 0 /var/cache/nginx/client_temp
RUN mkdir -p /var/cache/nginx/proxy_temp && chgrp 0 /var/cache/nginx/proxy_temp
RUN sed -i -e 's/user  nginx;/#user nginx;/g' /etc/nginx/nginx.conf
