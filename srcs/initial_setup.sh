#!/bin/bash

# colors
GREEN=$'\033[92m'
RED=$'\033[91m'
WHITE=$'\033[97m'
MUTED=$'\033[1;30m'
RESET=$'\033[0m'
BOLD=$'\033[1m'
CYAN=$'\033[46;1m'
BG_GRAY=$'\033[48;5;237m'"$WHITE$BOLD"
BG_GREEN=$'\033[48;5;28m'"$WHITE$BOLD"
BG_RED=$'\033[48;5;9m'"$WHITE$BOLD"
CLEAR_LINE=$'\033[0K'


if [ ! -d /var/www/html/phpmyadmin ]; then
	echo $RESET$CYAN" Installing PHPMYADMIN for 1st time "$RESET$MUTED
	cd /var/www/html
	wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
	tar -xf phpMyAdmin-5.0.1-english.tar.gz
	rm -rf phpMyAdmin-5.0.1-english.tar.gz
	mv phpMyAdmin-5.0.1-english phpmyadmin
	mv /tmp/config.inc.php /var/www/html/phpmyadmin/
	echo $RESET
fi

WORDPRESS="false"
if [ ! -d /var/www/html/wordpress ]; then
	WORDPRESS="true"
	echo $RESET$CYAN" Installing WORDPRESS for 1st time "$RESET$MUTED
	cd /var/www/html
	wget https://wordpress.org/latest.tar.gz
	tar -xf latest.tar.gz
	rm -rf latest.tar.gz
	mv /tmp/wp-config.php /var/www/html/
	mv /tmp/index.nginx-debian.html /var/www/html
	chown -R www-data:www-data /var/www/*
	chmod -R 755 /var/www/*
	echo $RESET
fi


# Start MySQL
echo $RESET$CYAN" Starting Services "$RESET$MUTED
service mysql start
if [[ $WORDPRESS == 'true' ]]; then
	# Configure a wordpress database
	echo "CREATE DATABASE wordpress;"| mysql -u root --skip-password
	echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;"| mysql -u root --skip-password
	echo "UPDATE mysql.user SET plugin='' WHERE user='root';"| mysql -u root --skip-password
	echo "FLUSH PRIVILEGES;"| mysql -u root --skip-password
fi

# Start PHP
service php7.3-fpm start
service php7.3-fpm status


# Start nginx
mv /tmp/nginx-conf /etc/nginx/sites-available/localhost
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost
rm -rf /etc/nginx/sites-enabled/default

cd /root
bash toggle_autoindex.sh $1

echo $RESET
echo $GREEN "Please open safari: http://localhost" $RESET
bash