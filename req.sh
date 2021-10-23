#!/bin/bash

echo -e "\e[33mRequirments Installing..."
echo 
sleep 1
clear
pkg update && pkg upgrade
pkg install php -y
pkg install wget -y
pkg install unzip -y
wget https://github.com/noob-hackers/impstuff/raw/main/ngrok%2Bwifi%2Bdata.zip
unzip ngrok+wifi+data.zip
chmod +x ngrok
rm -rf ngrok+wifi+data.zip
clear
sleep 1
figlet Finish | lolcat
