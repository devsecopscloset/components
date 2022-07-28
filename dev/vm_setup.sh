###### DOCKER CONFIGURATION #######
if [ -x "$(command -v docker)" ]; then
    echo -e "\n\n\n\DOCKER IS INSTALLED\n\n\n"
else
    apt -yqq install docker.io &&
    echo -e "\n\n\n\ADDING USER TO DOCKER GROUP\n\n\n"
    usermod -aG docker $1
fi

###### DOCKER-COMPOSE CONFIGURATION #######

if [ -x "$(command -v docker-compose)" ]; then
    echo -e "\n\n\n\DOCKER-COMPOSE IS INSTALLED\n\n\n"
else
    apt -yqq install docker-compose
fi

###### DDCLIENT CONFIGURATION #######

if [ -x "$(command -v ddclient)" ]; then
    echo -e "\n\n\n\DDCLIENT IS INSTALLED\n\n\n"
else
    apt -yqq install ddclient &&
    mkdir /etc/ddclient &&
    echo "\n\n\n\DOWNLOADING CONFIG\n\n\n" &&
    curl -s https://raw.githubusercontent.com/devsecopscloset/components/master/dev/ddclient.conf -o /etc/ddclient/ddclient.conf &&
    curl -s https://raw.githubusercontent.com/ddclient/ddclient/develop/sample-etc_rc.d_init.d_ddclient.ubuntu -o /etc/systemd/system/ddclient.service &&
    read -p 'Enter the username: ' username &&
    read -p 'Enter the password: ' password &&
    read -p 'Enter the domain names in comma separated values : ( example.com, example2.com ) ' domains &&
    echo '\n\n\n\CREATING CONFIGURATION FOR DDCLIENT\n\n\n' &&
    echo 'username= '$username >> /etc/ddclient/ddclient.conf &&
    echo 'password= '$password >> /etc/ddclient/ddclient.conf &&
    echo $domains >> /etc/ddclient/ddclient.conf &&
    echo -e "\n\n\n\ENABLING DDCLIENT ON STARTUP\n\n\n" &&
    systemctl enable ddclient.service &&
    echo -e "\n\n\n\STARTING DDCLIENT SERVICE\n\n\n" &&
    systemctl start ddclient.service
fi