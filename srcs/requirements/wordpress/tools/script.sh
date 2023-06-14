#!/bin/sh 
WORDPRESS_DIR="/var/www/html/wordpress"
until mysqladmin ping --user=${WORDPRESS_DB_USER}--password=${WORDPRESS_DB_PASSWORD} --host=mariadb 2>/dev/null
do 
	echo "Waiting for mariadb database availability..."
	sleep 2
done
	echo "Mariadb database available."
if [ ! -f "$WORDPRESS_DIR/wp-config.php" ]; then
		echo "Wordpress is not install, installing..."
		mv /home/wp-config.php /var/www/html/wordpress 
		wp	--allow-root \
		--path=/var/www/html/wordpress/ core install \
		--url=tkempf.42.fr \
		--title=$WORDPRESS_WEBSITE_TITLE \
		--admin_user=$WORDPRESS_ADMIN \
		--admin_password=$WORDPRESS_ADMIN_PASSWORD \
		--admin_email=$WORDPRESS_ADMIN_EMAIL \
		--locale=FR \
		--skip-email 
		wp --allow-root --path=/var/www/html/wordpress/ option update default_comment_status open 
		echo "Comment allowed."
		wp --allow-root --path=/var/www/html/wordpress/ post update $(wp --allow-root --path=/var/www/html/wordpress/ post list --format=ids) --comment_status=open
		echo "Existing post updated."
		wp --allow-root --path=/var/www/html/wordpress/ user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL --user_pass=$WORDPRESS_USER_PASSWORD
		echo "User created."
		wp --allow-root --path=/var/www/html/wordpress/ option update comment_moderation 0
		wp --allow-root --path=/var/www/html/wordpress/ option update comment_previously_approved 0
		echo "Moderation for comment disable."
fi;
	echo "Wordpress is fully configure and operational."
	exec /usr/sbin/php-fpm7.3