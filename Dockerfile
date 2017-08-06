FROM nginx:alpine

RUN mkdir -p /var/cache/nginx/client_temp && chgrp 0 /var/cache/nginx/client_temp
RUN mkdir -p /var/cache/nginx/proxy_temp && chgrp 0 /var/cache/nginx/proxy_temp
RUN mkdir -p /var/cache/nginx/fastcgi_temp && chgrp 0 /var/cache/nginx/fastcgi_temp
RUN mkdir -p /var/cache/nginx/uwsgi_temp && chgrp 0 /var/cache/nginx/uwsgi_temp
RUN mkdir -p /var/cache/nginx/scgi_temp && chgrp 0 /var/cache/nginx/scgi_temp

# Openshift "magically" drops privs for us from the get go
RUN sed -i -e 's/user  nginx;/#user nginx;/g' /etc/nginx/nginx.conf

# So listen 80 won't work either
RUN sed -i -e 's/80;/8080;/g' /etc/nginx/conf.d/default.conf
