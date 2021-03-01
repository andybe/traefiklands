#!/bin/bash
DISTRO=Debian
OS_VERSION=buster

echo "Distribution: ${DISTRO}"
echo "OS version: ${OS_VERSION}"

#Update all installed packages.
sudo apt-get update
sudo apt-get upgrade

# install some utils
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

#Install Docker
if [ "$DISTRO" == "Debian" ]; then
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
  if [ "$OS_VERSION" == "9" ]; then
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable"
  elif [ "$OS_VERSION" == "10" ]; then
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian buster stable"
  elif [ "$OS_VERSION" == "11" ]; then
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian bullseye stable"
  else
      #default tested version
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian buster stable"
   fi
elif [ "$DISTRO" == "Ubuntu" ]; then
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  if [ "$OS_VERSION" == "16.04" ]; then
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
  elif [ "$OS_VERSION" == "18.04" ]; then
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
  elif [ "$OS_VERSION" == "20.04" ]; then
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
  else
      #default tested version
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
   fi
fi

sudo apt-get update
sudo apt-get install -y containerd.io docker-ce docker-ce-cli

# Create required directories
sudo mkdir -p /etc/systemd/system/docker.service.d

# Create daemon json config file
sudo tee /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

# Start and enable Services
sudo systemctl daemon-reload 
sudo systemctl restart docker
sudo systemctl enable docker

# The version of docker-compose can be outdated. - https://docs.docker.com/compose/install/
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Done."
