FROM alpine:3.4

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && \
    apk --update add \
      bash \
      curl \
      git \
      openssl \
      php7 \
      php7-ctype \
      php7-dom \
      php7-iconv \
      php7-json \
      php7-mbstring \
      php7-memcached \
      php7-mysqli \
      php7-openssl \
      php7-pdo \
      php7-pdo_dblib \
      php7-pdo_mysql \
      php7-phar && \
    rm -rf /var/cache/apk/*

RUN ln -s /usr/bin/php7 /usr/bin/php

# Install Composer
ENV COMPOSER_VERSION 1.2.0
RUN	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION} && \
  chmod +x /usr/local/bin/composer
RUN composer --version

# Install Drush using Composer.
ENV DRUSH_VERSION 7.3.0
RUN git clone https://github.com/drush-ops/drush.git /usr/local/src/drush && \
    cd /usr/local/src/drush && \
    git checkout ${DRUSH_VERSION} && \
    ln -s /usr/local/src/drush/drush /usr/bin/drush && \
    composer install
RUN drush --version

WORKDIR /var/www/html

COPY run.sh /tmp/run.sh
RUN chmod +x /tmp/run.sh
ENTRYPOINT ["/tmp/run.sh"]
