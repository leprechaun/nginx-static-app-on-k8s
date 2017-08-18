FROM nginx:alpine

ADD make-writable /usr/local/bin/
RUN chmod 755 /usr/local/bin/make-writable

RUN mkdir -p /var/cache/nginx/client_temp && chgrp 0 /var/cache/nginx/client_temp
RUN mkdir -p /var/cache/nginx/proxy_temp && chgrp 0 /var/cache/nginx/proxy_temp
RUN mkdir -p /var/cache/nginx/fastcgi_temp && chgrp 0 /var/cache/nginx/fastcgi_temp
RUN mkdir -p /var/cache/nginx/uwsgi_temp && chgrp 0 /var/cache/nginx/uwsgi_temp
RUN mkdir -p /var/cache/nginx/scgi_temp && chgrp 0 /var/cache/nginx/scgi_temp

# More openshift stuff
RUN sed -i -e 's/user  nginx;/#user nginx;/g' /etc/nginx/nginx.conf
RUN sed -i -e 's/80;/8081;/g' /etc/nginx/conf.d/default.conf
RUN sed -i -e 's:/var/run/nginx.pid:/tmp/nginx.pid:g' /etc/nginx/nginx.conf
RUN chgrp -R 0 /var/run/
RUN chmod -R 777 /var/run

ADD index.html /usr/share/nginx/html/index.html
RUN sed -i -e "s/#DATE#/$(date)/g" /usr/share/nginx/html/index.html


ADD bootstrap.sh /usr/local/bin/bootstrap
RUN chmod 755 /usr/local/bin/bootstrap



ADD index.html /usr/share/nginx/html/index.html
ADD environment.gif /usr/share/nginx/html/images/environment.gif

RUN make-writable /usr/share/nginx/html/
RUN make-writable /usr/share/nginx/html/index.html

ENV GIT_COMMIT=${GIT_COMMIT}

ENTRYPOINT ["bootstrap"]
CMD ["nginx", "-g", "daemon off;"]

EXPOSE 8080
