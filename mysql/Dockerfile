FROM alpine:edge

RUN addgroup -g 83 -S mysql && \
    adduser -u 83 -D -S -G mysql mysql

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && \
    apk add --no-cache --virtual .build-deps \
      bash \
      mariadb \
      mariadb-client  \
      su-exec \
      tzdata && \
    rm -rf /var/cache/apk/*

RUN	mkdir -p /var/lib/mysql /var/run/mysqld && \
  chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
  chmod 777 /var/run/mysqld

VOLUME /var/lib/mysql

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY conf/my.cnf /etc/mysql/my.cnf

RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]
