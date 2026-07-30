#!/usr/bin/env sh
apache2ctl start

tail -f /var/log/apache2/access.log /var/log/apache2/error.log /var/log/apache2/php_error.log
