#!/bin/bash

# Dev environment operations.
drush -y en stage_file_proxy devel
drush vset stage_file_proxy_origin 'https://www.oist.jp'
drush vset stage_file_proxy_use_imagecache_root 0
# Replace by a generic one
drush sqlq "UPDATE users SET mail = 'pedro.cambra@oist.jp' WHERE uid = 1"

# Run php fpm
php-fpm7 --allow-to-run-as-root --nodaemonize --fpm-config /etc/php7/php-fpm.conf
