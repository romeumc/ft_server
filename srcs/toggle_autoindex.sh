#!/bin/bash

INDEX=$1
FILE=/etc/nginx/sites-available/localhost

if [[ $INDEX == 'off' ]];
then
	sed -i "s|autoindex on|autoindex off|" $FILE
	sed -i "s|#index index.html index.htm index.nginx-debian.html index.php;|index index.html index.htm index.nginx-debian.html index.php;|" $FILE
	service nginx restart > /dev/null
	service nginx status
	echo "Autoindex is disabled"
elif [[ $INDEX == 'on' ]];
then
	sed -i "s|autoindex off|autoindex on|" $FILE
	sed -i "s|index index.html index.htm index.nginx-debian.html index.php;|#index index.html index.htm index.nginx-debian.html index.php;|" $FILE
	service nginx restart > /dev/null
	service nginx status
	echo "Autoindex is enabled"
else
	echo "Wrong usage: bash toogle_autoindex.sh {on|off}"
fi
