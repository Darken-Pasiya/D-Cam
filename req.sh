#!/bin/bash

echo -e "\e[33mRequirments Installing..."
echo 
sleep 1
clear
pkg update && pkg upgrade
pkg install php -y
pkg install wget -y
pkg install unzip -y
echo " \e[36m  Please Wait For Downloading Ngrok"
cd
wget https://github.com/noob-hackers/impstuff/raw/main/ngrok%2Bwifi%2Bdata.zip > /dev/null 2>&1
unzip ngrok+wifi+data.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok+wifi+data.zip
mv ngrok 
clear
sleep 1
figlet Finish | lolcat
