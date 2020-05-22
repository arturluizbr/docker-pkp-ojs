#!/usr/bin/env bash

if [[ ! -s ${APP_DIR}/config.inc.php ]]; then

# Loads OJS default enviroment variables
source /etc/ojs.config.env

# Creates OJS configuration file
config-creator > ${APP_DIR}/config.inc.php

# set php settings to production values
# NB this has to be inserted after the previous call
# otherwise the config-creator script won't be able to
# access the $_ENV array
ln -s ${PHP_INI_DIR}/php.ini-production ${PHP_INI_DIR}/php.ini

# When running behind a SSL-terminating reverse proxy
# OJS doesn't get the protocol right by itself
# We need to provide the 'HTTPS' key in the PHP $_SERVER variable
# by tweaking the apache server running in the container
echo 'SetEnvIf X-Forwarded-Proto "^https$" HTTPS=on' > /etc/apache2/conf-enabled/https-on.conf

fi 

exec "$@"
