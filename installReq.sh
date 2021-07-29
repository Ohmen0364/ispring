#!/bin/bash
sudo apt update
sudo apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common vim -y
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-compose -y
sudo systemctl disable apache2
sudo usermod -aG docker $USER
sudo mkdir tc-logs tc-data mysql
sudo chown -R $USER:docker ./*
sudo cp hosts /etc/hosts
sudo reboot
