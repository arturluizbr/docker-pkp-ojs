#!/usr/bin/env bash

# Loads OJS default enviroment variables
source /etc/ojs.config.env

# Creates OJS configuration file
config-creator > ${APP_DIR}/config.inc.php

# Defines a few alias for PKP Tools
if [ "$1" == "pkp" ]; then
    case $2 in 
    "dbXMLtoSQL")
        php -c ${PHP_INI_DIR} ${APP_DIR}/tools/dbXMLtoSQL.php ${@:3}
        ;;
    "install")
        php -c ${PHP_INI_DIR} ${APP_DIR}/tools/install.php ${@:3}
        ;;
    "upgrade")
        php -c ${PHP_INI_DIR} ${APP_DIR}/tools/upgrade.php ${@:3}
        ;;
    *)
        echo "Tool not found, check tools folder for a list of available tools."
        ;;
    esac
else
    exec "$@"
fi
