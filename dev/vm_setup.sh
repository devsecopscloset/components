###### DOCKER CONFIGURATION #######
if [ -x "$(command -v docker)" ]; then
    echo -e "\n\n\n\x1b[31mDOCKER IS INSTALLED\n\n\n"
else
    apt install docker.io -yqq &&
    echo -e "\n\n\n\x1b[31mADDING USER TO DOCKER GROUP\n\n\n"
    usermod -aG docker $1 &&
fi

###### DOCKER-COMPOSE CONFIGURATION #######

if [ -x "$(command -v docker-compose)" ]; then
    echo -e "\n\n\n\x1b[31mDOCKER-COMPOSE IS INSTALLED\n\n\n"
else
    apt install docker-compose -yqq
fi

###### DDCLIENT CONFIGURATION #######

if [ -x "$(command -v ddclient)" ]; then
    echo "\n\n\n\x1b[31mDDCLIENT IS INSTALLED\n\n\n"
else
    apt install ddclient -yqq &&
    mkdir /etc/ddclient &&
    echo "\n\n\n\x1b[31mDOWNLOADING CONFIG\n\n\n" &&
    curl -s https://raw.githubusercontent.com/devsecopscloset/components/master/dev/ddclient.conf -o /etc/ddclient/ddclient.conf &&
    curl -s https://raw.githubusercontent.com/ddclient/ddclient/develop/sample-etc_rc.d_init.d_ddclient.ubuntu -o /etc/systemd/system/ddclient.service &&
    read -p '\x1b[33mEnter the username: ' username &&
    read -p '\x1b[33mEnter the password: ' password &&
    read -p '\x1b[33mEnter the domain names in comma separated values : \x1b[32m( example.com, example2.com ) ' domains &&
    echo '\n\n\n\x1b[31mCREATING CONFIGURATION FOR DDCLIENT\n\n\n' &&
    echo 'username= '$username >> /etc/ddclient/ddclient.conf &&
    echo 'password= '$password >> /etc/ddclient/ddclient.conf &&
    echo $domains >> /etc/ddclient/ddclient.conf &&
    echo "\n\n\n\x1b[31mENABLING DDCLIENT ON STARTUP\n\n\n" &&
    systemctl enable ddclient.service &&
    echo "\n\n\n\x1b[31mSTARTING DDCLIENT SERVICE\n\n\n" &&
    systemctl start ddclient.service &&
fi