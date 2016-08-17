FROM alpine:3.4

# Install nginx
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update
RUN apk add nginx ca-certificates

RUN apk add -u musl
RUN rm -rf /var/cache/apk/*
RUN mkdir -p /tmp/nginx && \
    mkdir -p /etc/nginx/sites-enabled && \
    mkdir -p /var/www/html && \
    chmod -R gu+w /var/www/html && \
    umask 774 /var/www/html

# Expose the ports for nginx
EXPOSE 8080 443

CMD ["/usr/sbin/nginx"]
