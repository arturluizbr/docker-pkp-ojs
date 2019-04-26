FROM php:7.3-apache

ENV APP_DIR=/var/www/html \
    TMP_DIR=/tmp
ARG BINARY=http://pkp.sfu.ca/ojs/download/ojs-3.1.2.tar.gz

ADD ${BINARY} ${TMP_DIR}
WORKDIR ${APP_DIR}
RUN tar xfz ${TMP_DIR}/ojs*.tar.gz --strip 1 \
    && chown -R www-data:www-data ${APP_DIR}/* \
    && rm -Rf ${TMP_DIR}/ojs*

COPY files/* ${TMP_DIR}/

RUN mv ${TMP_DIR}/config-creator.php /bin/config-creator \
    && mv ${TMP_DIR}/pkp.sh /bin/pkp \
    && mv ${TMP_DIR}/entrypoint.sh /entrypoint.sh \
    && mv ${TMP_DIR}/ojs.config.env /etc/ojs.config.env \
    && chmod +x /bin/config-creator \
    && chmod +x /bin/pkp \
    && chmod +x /entrypoint.sh \
    && docker-php-ext-install mysqli \
    && echo "error_log=/dev/stderr" > $PHP_INI_DIR/conf.d/error.ini

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "apache2ctl", "-DFOREGROUND" ]