#!/bin/bash
#
sudo apt -q update
sudo apt -yq install gnupg curl 
sudo apt-key adv \
  --keyserver hkp://keyserver.ubuntu.com:80 \
  --recv-keys 0xB1998361219BD9C9

mkdir /tmp/zulu
cd /tmp/zulu
curl -O https://cdn.azul.com/zulu/bin/zulu-repo_1.0.0-3_all.deb

sudo apt install ./zulu-repo_1.0.0-3_all.deb
sudo apt update

sudo apt install zulu17-jdk

cd ~

echo "Azul Zulu Java 17 has been successfully Installed"
