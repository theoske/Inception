FROM debian:buster
RUN apt-get update \ 
&& apt-get -y install mariadb-server mariadb-client net-tools
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d
EXPOSE 3306
ADD tools/script.sh .
RUN chmod 777 script.sh
ENTRYPOINT ["/bin/sh","script.sh"]