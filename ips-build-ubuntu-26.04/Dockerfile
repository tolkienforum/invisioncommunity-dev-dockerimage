FROM ubuntu:26.04

ENV TZ=Europe/Zurich \
    TERM=xterm \
    DEBIAN_FRONTEND=noninteractive

# PHP Backport
RUN apt-get update && apt-get upgrade -yq
RUN apt-get install -yq software-properties-common
RUN apt-get install -yq ca-certificates curl lsb-release
RUN curl -fsSLo /tmp/debsuryorg-archive-keyring.deb https://packages.sury.org/debsuryorg-archive-keyring.deb
RUN dpkg -i /tmp/debsuryorg-archive-keyring.deb
RUN echo "deb [signed-by=/usr/share/keyrings/debsuryorg-archive-keyring.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

# continue as usual
RUN apt-get update && apt-get -yq upgrade

# IPB PHP Requirements
RUN apt-get -yq install php8.2 \
    php8.2-mbstring \
    php8.2-curl \
    php8.2-xml \
    php8.2-gd \
    php8.2-mysql \
    php8.2-zip \
    php8.2-gmp \
    php8.2-intl

RUN apt-get -yq install  \
    apache2 libapache2-mod-php \
    git nano tree curl unzip

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN echo "PHP_value error_log /var/log/apache2/php_error.log" >> /etc/apache2/apache2.conf
RUN touch /var/log/apache2/php_error.log

RUN a2enmod rewrite actions include

ADD apache2-startup.sh /usr/sbin/apache2-startup.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80

# Docker has a default entrypoint: /bin/sh -c
# ENTRYPOINT [ "/bin/sh -c" ]
# CMD is passed to the entrypoint or overwritten on the commandline
CMD ["/usr/sbin/apache2-startup.sh"]
