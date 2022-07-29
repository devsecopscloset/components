#!/bin/bash

if [[ ! `docker ps -a | awk '{print $NF}' | grep closet_dd` ]]
then 
	docker run -p 8000:8000 -d -v $HOME/config/ip_vol:/ip_vol --name closet_dd devsecopscloset/closet_dojo:dev
fi

if [[ ! `docker ps -a | awk '{print $NF}' | grep closet_octant` ]]
then
	docker run -v $HOME/kubeconfig:/kubeconfig -p 7777:7777 -d --name closet_octant devsecopscloset/octant:dev
fi

if [[ ! `docker ps -a | awk '{print $NF}' | grep closet_start` ]]
then
	docker run -v $HOME/config:/root/config -v $HOME/kubeconfig:/root/.kube -d devsecopscloset/closet_deploy:dev
elif [[ `docker ps -a -f status=exited | grep closet_start` ]]
then
	docker rm -f closet_start &&
	docker run -v $HOME/config:/root/config -v $HOME/kubeconfig:/root/.kube -d devsecopscloset/closet_deploy:dev
fi