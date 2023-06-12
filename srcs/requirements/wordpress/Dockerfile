FROM debian:buster
WORKDIR /var/www/html
RUN apt-get update \
		&& apt-get -y install php7.3 php7.3-fpm php7.3-mysql default-mysql-client wget\ 
		&& wget https://wordpress.org/wordpress-6.1.1.tar.gz \
		&& wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
		&& chmod +x wp-cli.phar \
		&& mv wp-cli.phar /usr/local/bin/wp \
		&& tar -xvf  wordpress-6.1.1.tar.gz -C /var/www/html/ \
		&& rm wordpress-6.1.1.tar.gz 
WORKDIR /var/www/html/wordpress
RUN chown -R www-data:www-data * \
		&& chmod -R 755 * \
		&& rm	wp-config-sample.php
WORKDIR /run/php
ADD conf/php-fpm.conf /etc/php/7.3/fpm
ADD conf/www.conf /etc/php/7.3/fpm/pool.d
WORKDIR /home
COPY /conf/wp-config.php .
COPY /tools/script.sh .
ENTRYPOINT ["/bin/sh","script.sh"]
