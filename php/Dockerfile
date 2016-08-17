FROM alpine:3.4

# Create user www-data
RUN addgroup -g 82 -S www-data && \
    adduser -u 82 -D -S -G www-data www-data

# Install PHP7, Pygments and Git
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && \
    apk --update add \
      php7 \
      php7-bcmath \
      php7-bz2 \
      php7-ctype \
      php7-curl \
      php7-dom \
      php7-exif \
      php7-fpm \
      php7-gd \
      php7-gettext \
      php7-gmp \
      php7-iconv \
      php7-intl \
      php7-json \
      php7-mbstring \
      php7-mcrypt \
      php7-memcached \
      php7-mysqli \
      php7-opcache \
  		php7-openssl \
      php7-pcntl \
      php7-pdo \
      php7-pdo_mysql \
      php7-phar \
      php7-session \
      php7-tidy \
      php7-xdebug \
      php7-xml \
      php7-xmlreader \
  		php7-xmlrpc \
      php7-zip \
      php7-zlib \
      bash \
      curl \
		  git \
      mysql-client \
      openssl \
		  py-pygments \
      unzip && \
    rm -rf /var/cache/apk/*

    # Build apcu & apcu_bc for PHP7
    RUN apk --update add \
        autoconf \
        build-base \
        libtool \
        php7-pear \
        php7-dev \
        alpine-sdk && \
        sed -i "s/exec \$PHP -C -n -q/exec \$PHP -C -q/g" /usr/bin/pecl && \
        printf "\n" | pecl install apcu apcu_bc-beta && \
        echo "extension=apcu.so" > /etc/php7/conf.d/apcu.ini && \
        echo "extension=apc.so"  > /etc/php7/conf.d/z_apc.ini && \
        sed -ie 's/-n//g' /usr/bin/pecl && \
    	  apk del --purge \
    		  autoconf \
          build-base \
          libtool \
    		  php7-pear \
    		  php7-dev \
          alpine-sdk && \
        rm -rf /var/cache/apk/*

# Link php7 exec to more standard php name
RUN ln -s /usr/bin/php7 /usr/bin/php \
    && rm -rf /etc/php7/php-fpm.d \
	  && mkdir -p /srv \
    && mkdir -p /data \
	  && mkdir -p /repo \
	  && mkdir -p /usr/local/sbin \
	  && mkdir -p /var/tmp/phd/log \
    && mkdir -p /var/logs/php-fpm \
    && ln -fs /proc/self/fd/2 /var/tmp/phd/log/daemons.log

# Install Composer
ENV COMPOSER_VERSION 1.2.0
RUN	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION} && \
  chmod +x /usr/local/bin/composer

# Install Drush using Composer.
ENV DRUSH_VERSION 7.3.0
RUN git clone https://github.com/drush-ops/drush.git /usr/local/src/drush && \
    cd /usr/local/src/drush && \
    git checkout ${DRUSH_VERSION} && \
    ln -s /usr/local/src/drush/drush /usr/bin/drush && \
    composer install
RUN drush --version

# Create workdir
RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www && \
    chmod -R 774 /var/www && \
    umask 774 /var/www
WORKDIR /var/www/html

EXPOSE 9000

COPY run.sh /tmp/run.sh
RUN chmod +x /tmp/run.sh
ENTRYPOINT ["/tmp/run.sh"]
