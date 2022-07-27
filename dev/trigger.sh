#!/bin/bash

cd ~ &&
docker-compose --compatibility up -d

#docker run -v $HOME/config:/root/config -v $HOME/kubeconfig:/root/.kube -d devsecopscloset/closet_deploy:dev