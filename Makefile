SRC = srcs/docker-compose.yml 
DOCKER=$(shell docker ps -a -q)
IMAGES=$(shell docker images -a -q)
VOLUMES=$(shell docker volume ls -q)
NETWORKS=$(shell docker network ls -q)

all: run

re : clean build

logs:
	docker-compose -f ${SRC} logs -f -t
run :   
	grep tkempf.42.fr /etc/hosts > /dev/null || sed '/127.0.0.1[\t ]*localhost/a\127.0.0.1       tkempf.42.fr' -i /etc/hosts
	grep www.tkempf.42.fr /etc/hosts /dev/null || sed '/127.0.0.1[\t ]*tkempf.42.fr/a\127.0.0.1       www.tkempf.42.fr' -i /etc/hosts
	mkdir -p /home/tkempf/data/data
	mkdir -p /home/tkempf/data/app
	docker-compose -f ${SRC} up
down :
	docker-compose -f ${SRC} down
stop :
	docker-compose -f ${SRC} stop
build :
	docker-compose -f ${SRC} build

clean : down 
	@test -z $(VOLUMES) ||  docker volume rm -f $(VOLUMES)
	@test -z $(DOCKER) || docker rm -f $(DOCKER)
	rm -rf /home/tkempf/data

fclean : down
	@test -z $(DOCKER) || docker rm -f $(DOCKER)
	docker system prune -a -f
	@test -z $(IMAGES) || docker rmi -f $(IMAGES)
	@test -z $(VOLUMES) || docker volume rm -f $(VOLUMES)
	rm -rf /home/tkempf/data/* 
	@test -z $(NETWORKS) || docker network rm -f $(NETWORKS) 2>/dev/null

.PHONY: up down stop build clean flcean all logs
