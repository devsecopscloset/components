#!/bin/bash

cd ~/django-DefectDojo &&
sed -i 's/DD_PORT:-8080/DD_PORT:-8000/g' &&
[ -x dc-up-d.sh ] || chmod +x dc-up-d.sh
/bin/bash dc-up-d.sh mysql-rabbitmq &&
# rm -rf ~/django-DefectDojo &&

if [[ ! `docker ps | awk '{print $NF}' | grep closet_octant` ]]
then
	docker run -v $HOME/kubeconfig:/kubeconfig -p 7777:7777 --restart always -d devsecopscloset/octant:dev
fi

docker run -v $HOME/config:/root/config -v $HOME/kubeconfig:/root/.kube -d devsecopscloset/closet_deploy:dev