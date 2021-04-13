FROM debian:buster
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y procps wget lsb-release

# install nginx, mysql, php
RUN apt-get install -y nginx
RUN apt-get -y install mariadb-server
RUN apt-get install -y php7.3-fpm php7.3-mysql php7.3-mbstring

# install phpAdmin
WORKDIR /var/www/html/
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
RUN mv phpMyAdmin-5.0.1-english phpmyadmin

# install wordpress
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz
COPY /srcs/wp-config.php .

# get certificate
RUN openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes \
	-subj "/C=PT/ST=Lisboa/L=Lisboa/O=42lisboa/OU=rmartins/CN=localhost" \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt
RUN chown -R www-data:www-data *
RUN chmod -R 755 /var/www/*


# mover linha para cima
WORKDIR /
COPY /srcs/index.html /var/www/html
COPY /srcs/config.inc.php /var/www/html/phpmyadmin
COPY /srcs/nginx-conf ./tmp

#testes certificate
# RUN atp-get install -y dnsutils curl
# RUN curl --silent https://raw.githubusercontent.com/srvrco/getssl/master/getssl > getssl ; chmod 700 getssl

WORKDIR /root
EXPOSE 80 443
COPY /srcs/initial_setup.sh .
CMD bash initial_setup.sh