FROM alpine:3.4

# Create user and groups
# Based on http://git.alpinelinux.org/cgit/aports/tree/main/nginx-initscripts/nginx-initscripts.pre-install
RUN addgroup -S -g 82 www-data && \
    addgroup -S nginx && \
    adduser -S -D -H -h /var/www/localhost/htdocs -s /sbin/nologin -G nginx -g nginx nginx && \
    addgroup nginx www-data

# Install nginx
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update
RUN apk add nginx ca-certificates

RUN apk add -u musl
RUN rm -rf /var/cache/apk/*
RUN mkdir -p /tmp/nginx && \
    mkdir -p /etc/nginx/sites-enabled

# COPY the configuration files
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/drupal8.conf /etc/nginx/sites-enabled/www.conf
COPY conf/ssl/nginx.crt /etc/nginx/ssl/nginx.crt
COPY conf/ssl/nginx.key /etc/nginx/ssl/nginx.key

# Expose the ports for nginx
EXPOSE 80 443

CMD ["/usr/sbin/nginx"]
