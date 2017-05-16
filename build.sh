#!/bin/bash

INSTANCE_RUNNING=`sudo docker ps --filter="ancestor=sylvain/devops" | wc -l`

# Build docker image
docker build -t sylvain/devops .

# Stop current instance if exists
if [ $INSTANCE_RUNNING -gt 1 ] ; then
    printf "Stopping sylvain/devops"
    docker stop prod-devops
    docker rm prod-devops
fi

docker run --name prod-devops -p 80:80 -d sylvain/devops