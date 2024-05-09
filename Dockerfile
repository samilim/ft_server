FROM debian:buster

RUN apt-get -y update \
&& apt-get -y install wget \
&& apt-get -y install openssl \
&& apt-get -y install nginx \
&& apt-get -y install mariadb-server \
&& apt-get -y install php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring \
&& apt-get -y clean

COPY ./srcs/init.sh ./tmp/init.sh
COPY ./srcs/nginx.conf ./tmp/nginx.conf
COPY ./srcs/phpmyadmin-config.inc.php ./tmp/phpmyadmin-config.inc.php
COPY ./srcs/wp-config.php ./tmp/wp-config.php

WORKDIR /tmp

EXPOSE 80 443

CMD bash init.sh