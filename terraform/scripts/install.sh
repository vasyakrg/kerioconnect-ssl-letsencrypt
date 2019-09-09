#!/bin/bash

echo "install prerequired soft"
sudo apt remove exim4-base
sudo apt install locales-all libsensors4 sysstat
sudo apt-get install locales-all
echo "install kerio-connect"
sudo dpkg -i kerio-connect-*.deb
