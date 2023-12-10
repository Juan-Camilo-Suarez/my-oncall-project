#!/bin/bash

echo "pulling oncall changes"
git --git-dir=./sre_hw_repo/.git pull origin latest

echo "stop oncall-principal old"
docker-compose -f ./my-oncall-project/docker-compose.yml stop oncall-principal

echo "build oncall-principal"
docker-compose -f ./my-oncall-project/docker-compose.yml build oncall-principal

echo "start oncall-main new"
docker-compose -f ./my-oncall-project/docker-compose.yml up -d oncall-principal

success="200"

while [ "$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8081)" != "$success" ]
    do
    echo "waiting for start oncall-main"
    sleep 1
done
sleep 5

echo "stop oncall-backup old"
docker-compose -f ./my-oncall-project/docker-compose.yml stop oncall-support

echo "build oncall-backup"
docker-compose -f ./my-oncall-project/docker-compose.yml build oncall-support

docker-compose -f ./my-oncall-project/docker-compose.yml ps
