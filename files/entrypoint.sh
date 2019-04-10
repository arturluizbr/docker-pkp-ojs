#!/usr/bin/env bash

# Loads OJS default enviroment variables
source /etc/ojs.config.env

# Creates OJS configuration file
config-creator > ${APP_DIR}/config.inc.php

exec "$@"
