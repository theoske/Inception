FROM debian:buster
RUN apt-get update && apt-get -y install nginx \
		&& apt-get -y install openssl \
		&& mkdir /etc/nginx/ssl \
		&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
		-subj "/C=FR/ST=Haut-Rhin/L=Mulhouse/O=42/CN=tkempf-e.42.fr" \
		&& sed -i '/ssl_prefer_server_ciphers on;/a        ssl_certificate /etc/nginx/ssl/nginx.crt;\n        ssl_certificate_key /etc/nginx/ssl/nginx.key;\n' /etc/nginx/nginx.conf 
WORKDIR /etc/nginx/sites-available
COPY conf/wordpress.conf .
COPY conf/fastcgi.conf ../snippets
WORKDIR /etc/nginx/sites-enabled
RUN ln -s /etc/nginx/sites-available/wordpress.conf /etc/nginx/sites-enabled/wordpress.conf
EXPOSE 443
CMD ["nginx","-g","daemon off;"]