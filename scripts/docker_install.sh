#!/bin/bash

# Remove older installed version 
apt-get remove -y docker docker-engine docker.io containerd runc

# Setup the Repository 

apt-get update -y

apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt-get update -y

# Installation of Docker Engine

apt-get install -y docker-ce docker-ce-cli containerd.io

# Add vagrant user to docker group

sudo usermod -aG docker vagrant

# Setup the systemd daemon.
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

mkdir -p /etc/systemd/system/docker.service.d

# Restart and enable docker service.
systemctl daemon-reload
systemctl restart docker
systemctl enable docker

# Hold Docker at this specific version.
apt-mark hold docker-ce