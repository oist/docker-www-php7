FROM alpine:3.4

# Create user and groups
# Based on http://git.alpinelinux.org/cgit/aports/tree/main/nginx-initscripts/nginx-initscripts.pre-install
RUN addgroup -S -g 82 www-data && \
    addgroup -S nginx && \
    adduser -S -D -H -h /var/www/localhost/htdocs -s /sbin/nologin -G nginx -g nginx nginx && \
    addgroup nginx www-data

# Install nginx
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && \
    apk --update add nginx ca-certificates && \
    rm -rf /var/cache/apk/*

RUN apk add -u musl
RUN mkdir -p /tmp/nginx && \
    mkdir -p /etc/nginx/sites-enabled

# COPY the configuration files
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/www.conf /etc/nginx/sites-enabled/www.conf
COPY conf/ssl/nginx.crt /etc/nginx/ssl/nginx.crt
COPY conf/ssl/nginx.key /etc/nginx/ssl/nginx.key

# Expose the ports for nginx
EXPOSE 80 443

CMD ["/usr/sbin/nginx"]
