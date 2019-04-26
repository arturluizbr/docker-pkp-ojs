#!/usr/bin/env bash

# Loads OJS default enviroment variables
source /etc/ojs.config.env

# Creates OJS configuration file
config-creator > ${APP_DIR}/config.inc.php

# When running behind a SSL-terminating reverse proxy
# some hacking is necessary to get SSL to work
# see https://forum.pkp.sfu.ca/t/ojs-3-behind-reverse-proxy-how-to-achieve/25055/9
# Simply set $HACK_BASE_URL to some value and it will be fixed here
if [ -n "$HACK_BASE_URL" ]; then
    sed -i 's+function getBaseUrl($allowProtocolRelative = false)+function getBaseUrl($allowProtocolRelative = true)+' ${APP_DIR}/lib/pkp/classes/core/PKPRequest.inc.php
fi

exec "$@"
