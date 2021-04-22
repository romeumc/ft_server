docker build . -t ft_server1:rmartins
docker run \
	--name ft_server1 \
	-it --rm -p 80:80 -p 443:443 \
	-v /home/rmartins/ft_Server/romeu1.ft_server/html:/var/www/html \
	-v /home/rmartins/ft_Server/romeu1.ft_server/mysql/lib:/var/lib/mysql \
	ft_server1:rmartins $1 \
	#-v /home/rmartins/ft_Server/romeu1.ft_server/mysql:/var/lib/mysql/wordpress \
	# -v /home/rmartins/ft_Server/romeu1.ft_server/mysql/etc:/etc/mysql \
	# -v /home/rmartins/ft_Server/romeu.ft_server/mysqld:/var/run/mysqld \
	# -v /home/rmartins/ft_Server/romeu.ft_server/srcs/romeu:/root/romeu \
	# -v /home/rmartins/ft_Server/romeu.ft_server/srcs/wordpress/:/var/www/html/wordpress/wp-content \
	# -e MYSQL_ROOT_PASSWORD=admin \
# docker run -d -t --rm -p 80:80 -p 443:443 ft_server:rmartins
