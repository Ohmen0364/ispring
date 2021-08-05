#!/bin/bash

installDocker(){
    if [[ -x "$(command -v curl)" ]]; then
        echo "curl found"
    else
        echo "curl not found"
        sudo wget https://github.com/moparisthebest/static-curl/releases/download/v7.78.0/curl-amd64 -O /usr/bin/curl
        sudo chmod +x /usr/bin/curl
    fi
    if [[ -x "$(command -v docker)" ]]; then
        echo "docker found"
    else
        sudo curl -fsSL https://get.docker.com/ | sudo sh
        sudo usermod -aG docker $USER
    fi
    if [[ -x "$(command -v docker-compose)" ]]; then
        echo "docker-compose found"
    else
        echo "docker-compose not found"
        sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
        sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    fi
}

configureSys(){
    mkdir ./data/tc/tc-logs ./data/mysql
    sudo chown -R $USER:docker ./*
    cat /etc/hosts >> ./config/hosts
    sudo cp ./config/hosts /etc/hosts
    sudo reboot
}

if [[ -x "$(command -v docker)" ]] && [[ -x "$(command -v docker-compose)" ]]; then
    configureSys;
else
    installDocker;
    configureSys;
fi
