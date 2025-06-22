FROM ubuntu:22.04

ENV TZ=Europe/Zurich \
    TERM=xterm \
    DEBIAN_FRONTEND=noninteractive

# PHP 8.4 Backport
RUN apt-get update && apt-get install -yq software-properties-common
RUN add-apt-repository -y ppa:ondrej/php
RUN add-apt-repository -y ppa:ondrej/apache2

# continue as usual
RUN apt-get update && apt-get -yq upgrade

# IPB PHP Requirements
RUN apt-get -yq install php-mbstring \
    php-curl \
    php-xml \
    php-gd \
    php-mysql \
    php-zip

RUN apt-get -yq install  \
    php-gmp apache2 libapache2-mod-php \
    git nano tree curl unzip

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN a2enmod rewrite actions include

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80

# Docker has a default entrypoint: /bin/sh -c
# ENTRYPOINT [ "/bin/sh -c" ]
# CMD is passed to the entrypoint or overwritten on the commandline
CMD ["apache2ctl", "-DFOREGROUND"]
