# Introduction

Development Setup for Invision Power Board Version 5.

The forum software must be downloaded from the client area - it is not included in the docker images used.

The purpose of this repository is plugin development and is not intended as production setup. You need docker installed locally.

Tested with:
- Docker Desktop 4.41.2 (191736) on MacOS 15.5
- Docker Engine: 28.1.1
- Docker Compose: v2.36.0-desktop.1


The image running the Apache2 Webserver, PHP and the Forum is based on Ubuntu 22.04 LTS.

Don't use this for a production forum!!! (I recommend running php as FCGI and together with suexec).

The forum software itself is not part of the image, it will be mounted into the image on startup (see below).


## Build only the Image for IPS (optional)

```
$ cd ./ips-build
$ docker build --pull -t ips:latest .
```

## Build and run the Images

Copy the `dist.env` file to `.env`.

Modify the .evn File to reflect your settings.

Download the Invision Power Board software from you client area, extract it into the folder you intend to work with it (does not need to be in here), and configure that path in the .env file.

Do not yet enable DEV mode or copy the developer tools. This needs to be done after the initial Forum setup.

Build and run the images:
```
$ docker-compose build
$ docker-compose up -d
```


## Using the Image

Go to http://localhost:20080/ips/ and use the installer to setup the forum.

The mysql settings:
- Host: mysql
- USer: root 
- Password: set in the .env file
- remove the socket setting (connection is via network)


Make sure to use "localhost" to access the Invisioncommunity via your browser and use "-TESTINSTALL" as suffix of your license key!

## Enable Developer Mode
After the installer completed and the forum is visible enable developer-mode 

```
cp constants.php /ips/
```

and copy the developer tools into the ips folder.

Any plugin development is done on the local file-system (the directory shared with the ips docker container).


## Check the database (optional)

The docker-compose contains phpmyadmin too. It can be found below http://localhost:30080/.

## Enable Forum features (Optional)

The docler-compose file comes with Elasticseach (can be enabled in the AdminCP) and Redis Cache (also needs to be enabled in AdminCP).

To peek into the search index a Kibana instance is running as well: http://localhost:40080


## IPS Developer Documentation Links

* [How to create a Test-Install](https://invisioncommunity.com/4guides/welcome/install-and-upgrade-r259/#testinstall)

  Make sure to use "localhost" to access the Invisioncommunity and "-TESTINSTALL" as suffix of your license key!

As of version 5 the developer tools are also downloaded from the client are.

* [Invision Community Requirements Checker 5.x](https://invisioncommunity.com/files/file/7046-invision-community-requirements-checker/)
* [Enable Developer Mode](https://invisioncommunity.com/developers/docs/general/enabling-developer-mode-r23/)
* [Developer Center](https://invisioncommunity.com/developers/)
* [Plugins Developer Center](https://invisioncommunity.com/developers/docs/development/plugins/overview-of-plugins-in-ips4-r41/)

Links from another time:

* [Invision Community Requirements Checker 4.x OLD VERSION](https://invisioncommunity.com/files/file/7046-invision-community-requirements-checker/)
* [Download Developer Tools v4 (OLD Version)](https://invisioncommunity.com/files/file/7185-developer-tools/)
