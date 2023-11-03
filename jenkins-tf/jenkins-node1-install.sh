#!/bin/bash
exec > >(tee -a /var/log/user-data.log) 2>&1

echo "Script started at: $(date)"

sudo apt-get update && sudo apt install -y fontconfig openjdk-17-jre
sudo -y apt-get install default-jre

sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt-get install -y python3.7
sudo apt-get install -y python3.7-venv
sudo apt-get install -y build-essential
sudo apt-get install -y libmysqlclient-dev
sudo apt-get install -y python3.7-dev

cd /home/ubuntu

sudo apt-get install -y ca-certificates curl gnupg

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo groupadd docker || true
sudo usermod -aG docker $USER  || true

newgrp docker

sudo chmod 666 /var/run/docker.sock

echo "Script completed at: $(date)"