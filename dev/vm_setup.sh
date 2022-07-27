###### DOCKER CONFIGURATION #######
if [ -x "$(command -v docker)" ]; then
    echo "Docker is installed"
else
    apt install docker.io -y &&
    echo "Adding user to docker group......."
    usermod -aG docker $1
    docker_install=1
fi

###### DOCKER-COMPOSE CONFIGURATION #######

if [ -x "$(command -v docker-compose)" ]; then
    echo "docker-compose is installed"
else
    apt install docker-compose -y &&
fi

###### DDCLIENT CONFIGURATION #######


if [ -x "$(command -v ddclient)" ]; then
    echo "ddclient is installed"
else
    apt install ddclient -y &&
    echo "Downloading config....." &&
    curl -s https://raw.githubusercontent.com/devsecopscloset/components/master/dev/ddclient.conf -o /etc/ddclient.conf
    read -p 'Enter the username: ' username
    read -p 'Enter the password: ' password
    read -p 'Enter the domain names in comma separated values : ( example.com, example2.com ) ' domains
    echo 'Creating Configuration for ddclient........'
    echo 'username: $username' >> /etc/ddclient.conf
    echo 'password: $password' >> /etc/ddclient.conf
    echo $domains >> /etc/ddclient.conf
    echo "enabling ddlient on startup......." &&
    systemctl enable ddclient
fi