#!/bin/sh
docker ps -a | awk '{ print $1 }' | grep -v CONTAINER | xargs docker rm -f
docker volume ls |  awk '{ print $2 }' | grep -v VOLUME | xargs docker volume rm
docker network ls | awk '{ print $1 }' | grep -v NETWORK | xargs docker network rm
docker images |  awk '{ print $3 }' | grep -v IMAGE | xargs docker rmi
