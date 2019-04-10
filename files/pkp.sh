#!/usr/bin/env bash
# Defines a few alias for PKP Tools
case $1 in 
"dbXMLtoSQL")
    shift
    php -c ${PHP_INI_DIR} ${APP_DIR}/tools/dbXMLtoSQL.php $@
    ;;
"install")
    shift
    php -c ${PHP_INI_DIR} ${APP_DIR}/tools/install.php $@
    ;;
"upgrade")
    shift
    php -c ${PHP_INI_DIR} ${APP_DIR}/tools/upgrade.php $@
    ;;
*)
    echo "Tool not found, check tools folder for a list of available tools."
    ;;
esac