sudo apt update &&
sudo apt upgrade -y &&
sudo apt install -y docker.io ddclient &&
sudo usermod -aG docker $USER
# COPY DDCLIENT CONFIG