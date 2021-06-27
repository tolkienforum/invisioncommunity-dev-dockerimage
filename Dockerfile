FROM ubuntu:18.04

ENV DATE_TIMEZONE Europe/Zurich
ENV TERM xterm

# MySQL Server
RUN echo 'mysql-server mysql-server/root_password password password' | debconf-set-selections
RUN echo 'mysql-server mysql-server/root_password_again password password' | debconf-set-selections
#RUN sed -ie "s/^bind-address\s*=\s*127\.0\.0\.1$/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# PHPMyAdmin
RUN echo "phpmyadmin phpmyadmin/internal/skip-preseed boolean true" | debconf-set-selections
RUN echo "phpmyadmin phpmyadmin/dbconfig-install boolean false" | debconf-set-selections
# RUN echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections
RUN echo 'phpmyadmin phpmyadmin/app-password-confirm password phpmyadmin_password ' | debconf-set-selections
RUN echo 'phpmyadmin phpmyadmin/mysql/admin-pass password password' | debconf-set-selections
RUN echo 'phpmyadmin phpmyadmin/mysql/app-pass password password' | debconf-set-selections
# RUN echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect" | debconf-set-selections
RUN echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections

RUN echo debconf debconf/frontend select Noninteractive | debconf-set-selections
# ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get -yq upgrade

# PHP Backports:
RUN apt-get install -y --no-install-recommends apt-utils software-properties-common
RUN add-apt-repository ppa:ondrej/php

RUN apt-get update
RUN apt-get -yq upgrade

# PHP Backports: install PHP 7.4
RUN apt-get -yq install \
	php7.4 \
	php7.4-bz2 \
	php7.4-cli \
	php7.4-common \
	php7.4-curl \
	php7.4-dev \
	php7.4-enchant \
	php7.4-gd \
	php7.4-gmp \
	php7.4-intl \
	php7.4-json \
	php7.4-mysql \
	php7.4-opcache \
	php7.4-phpdbg \
	php7.4-pspell \
	php7.4-readline \
	php7.4-tidy \
	php7.4-xsl \
    php7.4-zip \
	php7.4-mbstring \
	php7.4-gmp
RUN apt-get -yq install apache2 libapache2-mod-php7.4
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN apt-get -yq install mysql-common mysql-server mysql-client phpmyadmin
RUN apt-get -yq install git nano tree curl unzip

# Fix: No directory, logging in with HOME=/
# RUN usermod -d /var/lib/mysql/ mysql

# reset NonInteractive mode:
RUN echo 'debconf debconf/frontend select Readline' | debconf-set-selections

RUN a2enmod rewrite actions include

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/var/lib/mysql", "/var/www/html/ips"]

EXPOSE 80
EXPOSE 3306

# Docker has a default entrypoint: /bin/sh -c
# ENTRYPOINT [ "/bin/sh -c" ]
# cmd is passed to the entrypoint or overwritten on the commandline
CMD service mysql start; /usr/sbin/apache2ctl -D FOREGROUND
