#!/bin/bash

# Sort of semaphore process to ensure that the db is there when we run the drush
# commands.
BOOTSTRAP=`drush status | grep "Drupal bootstrap                :  Successful" | wc -l`
until [ "$BOOTSTRAP" -ge "1" ]; do
  >&2 echo "Waiting for the database to be ready"
  BOOTSTRAP=`drush status | grep "Drupal bootstrap                :  Successful" | wc -l`
  sleep 5
done
>&2 echo "Running drush commands"

# Dev environment operations.
drush -y en stage_file_proxy devel
drush vset stage_file_proxy_origin 'https://www.oist.jp'
drush vset stage_file_proxy_use_imagecache_root 0
# Replace by a generic one
drush sqlq "UPDATE users SET mail = 'pedro.cambra@oist.jp' WHERE uid = 1"
echo "--------------------------------------------------------------------------"
echo "****************************** Here's a uli ******************************"
drush uli
echo "--------------------------------------------------------------------------"

# Run php fpm
php-fpm7 --nodaemonize --fpm-config /etc/php7/php-fpm.conf
