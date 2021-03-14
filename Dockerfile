FROM debian:buster
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y procps wget lsb-release

# install nginx, mysql, php
# RUN openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes -subj "/C=PT/ST=Lisboa/L=Lisboa/O=42lisboa/OU=42lisboa/CN=localhost" -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
RUN apt-get install -y nginx
RUN apt-get -y install mariadb-server
# RUN apt-get -y install php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring
RUN apt-get install -y php7.3-fpm php7.3-mysql
COPY ./srcs/nginx-conf ./tmp


# install phpAdmin
WORKDIR /var/www/html/
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
RUN mv phpMyAdmin-5.0.1-english phpmyadmin
COPY /srcs/config.inc.php phpmyadmin

# install wordpress
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz
COPY /srcs/wp-config.php .

RUN openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes -subj "/C=PT/ST=Lisboa/L=Lisboa/O=42lisboa/OU=42lisboa/CN=localhost" -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
# RUN openssl req -x509 -nodes -new -sha256 -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.pem -subj "/C=PT/ST=Lisboa/L=Lisboa/O=42lisboa/OU=42lisboa/CN=localhost"
# RUN openssl x509 -outform pem -in /etc/ssl/certs/nginx-selfsigned.pem -out /etc/ssl/private/nginx-selfsigned.crt
RUN chown -R www-data:www-data *
RUN chmod -R 755 /var/www/*

WORKDIR /root
COPY /srcs/initial_setup.sh .
CMD bash initial_setup.sh
EXPOSE 80 443