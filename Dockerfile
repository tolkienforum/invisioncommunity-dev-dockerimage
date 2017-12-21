FROM ubuntu:16.04

# ARG IPS_ZIP_FILE=invision-community-4.2.6.zip

ENV DATE_TIMEZONE Europe/Zurich
ENV TERM xterm



# MySQL Server
RUN echo 'mysql-server mysql-server/root_password password password' | debconf-set-selections
RUN echo 'mysql-server mysql-server/root_password_again password password' | debconf-set-selections
#RUN sed -ie "s/^bind-address\s*=\s*127\.0\.0\.1$/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# PHPMyAdmin
RUN echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections
RUN echo 'phpmyadmin phpmyadmin/app-password-confirm password phpmyadmin_password ' | debconf-set-selections
RUN echo 'phpmyadmin phpmyadmin/mysql/admin-pass password password' | debconf-set-selections
RUN echo 'phpmyadmin phpmyadmin/mysql/app-pass password password' | debconf-set-selections
RUN echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections

RUN echo debconf debconf/frontend select Noninteractive | debconf-set-selections
# ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get -yq upgrade
RUN apt-get install -y --no-install-recommends apt-utils

RUN apt-get -yq install \
	php7.0 \
	php7.0-bz2 \
	php7.0-cli \
	php7.0-common \
	php7.0-curl \
	php7.0-dev \
	php7.0-enchant \
	php7.0-gd \
	php7.0-gmp \
	php7.0-intl \
	php7.0-json \
	php7.0-mcrypt \
	php7.0-mysql \
	php7.0-opcache \
	php7.0-phpdbg \
	php7.0-pspell \
	php7.0-readline \
	php7.0-recode \
	php7.0-tidy \
	php7.0-xsl \
    php7.0-zip
RUN apt-get -yq install apache2 libapache2-mod-php7.0
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN apt-get -yq install mysql-common mysql-server mysql-client phpmyadmin
RUN apt-get -yq install git nano tree curl unzip

# Fix: No directory, logging in with HOME=/
# RUN usermod -d /var/lib/mysql/ mysql


# reset NonInteractive mode:
RUN echo 'debconf debconf/frontend select Readline' | debconf-set-selections
# RUN dpkg-reconfigure debconf

RUN a2enmod rewrite actions include

#COPY ${IPS_ZIP_FILE} /tmp/
#COPY info.php /var/www/html/
#RUN cd /tmp \
#    && unzip -q /tmp/${IPS_ZIP_FILE} \
#    && cd ips_* \
#    && mkdir -p /var/www/html/ips \
#    && cp -r . /var/www/html/ips \
#    && chown -R www-data:www-data /var/www/html \
#    && rm -Rf /tmp/${IPS_ZIP_FILE} /tmp/ips_*

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/var/lib/mysql", "/var/www/html/ips"]

EXPOSE 80
EXPOSE 3306

# Docker has a default entrypoint: /bin/sh -c
# ENTRYPOINT [ "/bin/sh -c" ]
# cmd is passed to the entrypoint or overwritten on the commandline
CMD service apache2 start; service mysql start
