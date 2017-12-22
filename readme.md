# Introduction

The purpose of this image is plugin development and is not intended as production image. You need docker installed locally to be able to work with this. Tested with docker 17.09.1-ce.

The image is based on Ubuntu 16.04 LTS and contains Apache, PHP7 and MySQL - it does not use the safest PHP setup! No suExec, no fcgi - just the good old apache module. So don't use this for a production forum!!!

The forum software itself is not part of the image, it will be mounted into the image on startup (see below).


## Build the Image

```
$ cd /path/to/dockerfile-location/
$ docker build -t ips:latest .
```

## Using the Image

To have MySQL store its data you need to mount a volume.

Create a volume for the mysql schema:
```
$ docker volume create mysql_data
````

Download the Invisioncommunity Software and unzip it into a folder "ips". Do not yet enable DEV mode or copy the developer tools.


Start the container (from the folder where the local ips files reside so the $PWD points to the correct directory):
```
$ cd /path/to/the/extracted/ips/files/
$ docker run -td --name ips -v mysql_data:/var/lib/mysql -v $PWD/ips:/var/www/html/ips -p 80:80 ips:latest
```

Go to http://localhost/ips/ and use the installer to setup the forum.
The mysql root user is "root", its password is "password".

After the installer completed and the forum is visible enable developer-mode 
```
cp constants.php /ips/
```

and copy the developer tools into the ips folder.

Any plugin development is done on the local file-system.


## Check the database (optional)

The image contains phpmyadmin too. It can be found below http://localhost/phpmyadmin/ - use the mysql root user to login (see above).


## IPS Developer Documentation Links

* [How to create a Test-Install](https://invisioncommunity.com/4guides/welcome/install-and-upgrade-r259/#testinstall)

  Make sure to use "localhost" to access the Invisioncommunity and "-TESTINSTALL" as suffix of your license key!

* [Enable Developer Mode](https://invisioncommunity.com/developers/docs/general/enabling-developer-mode-r23/)
* [Download Developer Tools](https://invisioncommunity.com/files/file/7185-developer-tools/)
* [Plugins Developer Center](https://invisioncommunity.com/developers/docs/development/plugins/overview-of-plugins-in-ips4-r41/)

