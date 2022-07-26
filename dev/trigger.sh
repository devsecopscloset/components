#!/bin/bash

cd ~ &&
docker-compose up

#docker run -v $HOME/config:/root/config -v $HOME/kubeconfig:/root/.kube -d devsecopscloset/closet_deploy:dev