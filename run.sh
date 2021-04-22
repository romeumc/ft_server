docker build . -t ft_server:rmartins
docker run \
	--name ft_server \
	-it --rm \
	-p 80:80 -p 443:443 \
	-v /home/rmartins/ft_Server/romeu.ft_server/data/html:/var/www/html \
	-v /home/rmartins/ft_Server/romeu.ft_server/data/mysql:/var/lib/mysql \
	ft_server:rmartins $1


# docker run -d -t --rm -p 80:80 -p 443:443 ft_server:rmartins
