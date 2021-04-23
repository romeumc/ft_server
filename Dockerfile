FROM debian:buster
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y procps wget lsb-release

# install nginx, php
RUN apt-get install -y nginx
RUN apt-get install -y php7.3-fpm php7.3-mysql php7.3-mbstring

# get certificate
RUN openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes \
	-subj "/C=PT/ST=Lisboa/L=Lisboa/O=42lisboa/OU=rmartins/CN=localhost" \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt

COPY /srcs/nginx-conf ./tmp
COPY /srcs/config.inc.php ./tmp
COPY /srcs/wp-config.php ./tmp
COPY /srcs/index.nginx-debian.html ./tmp

RUN apt-get install -y mariadb-server

WORKDIR /root
EXPOSE 80 443
COPY /srcs/toggle_autoindex.sh .
COPY /srcs/initial_setup.sh .
ENTRYPOINT ["bash", "initial_setup.sh"]
CMD ["off"]