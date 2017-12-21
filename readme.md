
Docker Image based on Ubuntu 16.04 LTS including Apache, PHP7+FCGI and MySQL.

The purpose of this image is plugin development and is not intended as production image.

Build Image:

$ docker build -t ips:latest


Usage:

To have MySQL store its data you need to mount a volume.

Create a volume for the mysql schema:
$ docker volume create mysql_data

Start the container:
$ docker run -it --name ipb -v mysql_data:/var/lib/mysql -v $PWD/ips:/var/www/html/ips -p 80:80 ips:latest


IPS Developer Docs:

Test-Install: https://invisioncommunity.com/4guides/welcome/install-and-upgrade-r259/#testinstall
Enable Developer Mode: https://invisioncommunity.com/developers/docs/general/enabling-developer-mode-r23/
Download Developer Tools: https://invisioncommunity.com/files/file/7185-developer-tools/

Plugins Developer Center: https://invisioncommunity.com/developers/docs/development/plugins/overview-of-plugins-in-ips4-r41/

