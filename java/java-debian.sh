#!/bin/bash
set -e

if [ "$(id -u)" != "0" ]; then
    echo "YOU MUST BE ROOT! This incident will not be reported. I suppose"
    exit 1
fi

read -p "Enter Java version (e.g., 8, 11, 17): " java_version

sudo apt update -qy
sudo apt install -yq gnupg curl

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9

# Download and install Azul repository package
curl -O https://cdn.azul.com/zulu/bin/zulu-repo_1.0.0-3_all.deb
sudo apt install -y ./zulu-repo_1.0.0-3_all.deb

sudo apt update -qy

sudo apt install -y "zulu${java_version}-jdk"

echo "Azul Zulu Java ${java_version} has been successfully Installed"
echo "I hope you have a great next 24 hours, https://git.dpaste.org/darrenofficial/scripts-util"