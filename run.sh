docker build . -t ft_server:rmartins
docker run \
	--name ft_server \
	-it --rm -p 81:80 -p 443:443 \
	ft_server:rmartins
	# -v /home/rmartins/ft_Server/romeu.ft_server/srcs/mysql:/var/lib/mysql/wordpress \
	# -v /home/rmartins/ft_Server/romeu.ft_server/srcs/wordpress/:/var/www/html/wordpress/wp-content \
# docker run -d -t --rm -p 81:80 -p 443:443 ft_server:rmartins
