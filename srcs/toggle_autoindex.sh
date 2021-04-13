#!/bin/bash

INDEX=$1
FILE=/etc/nginx/sites-available/localhost

if [[ $INDEX == 'off' ]];
then
	sed -i "s|autoindex on|autoindex off|" $FILE
	service nginx restart
	echo "Autoindex is disabled"
elif [[ $INDEX == 'on' ]];
then
	sed -i "s|autoindex off|autoindex on|" $FILE
	service nginx restart
	echo "Autoindex is enabled"
else
	echo "Wrong usage: bash toogle_autoindex.sh {on|off}"
fi
