folder=$(pwd)
echo $folder
docker run \
	--name ft_server \
	-it --rm \
	-p 80:80 -p 443:443 \
	-v vol1:/var/www/html \
	-v vol2:/var/lib/mysql \
	ft_server:rmartins $1


# docker run -d -t --rm -p 80:80 -p 443:443 ft_server:rmartins
