FROM leprechaun/nginx-on-k8s

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
