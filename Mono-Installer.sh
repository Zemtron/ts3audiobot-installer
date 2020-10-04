if ! lolcat -v COMMAND &> /dev/null 
then
wget https://github.com/busyloop/lolcat/archive/master.zip
apt-get install unzip
 unzip master.zip
 cd lolcat-master/bin
 apt-get install rubygems -y
 gem install lolcat
fi
if ! figlet -v COMMAND &> /dev/null 
then
 apt-get install -y figlet
fi
function Message() {
	echo -e "${@}" | lolcat -a -d 10
}


clear
sleep 1.0
    figlet MonoInstaller | lolcat
    Message "#################################################################"
    
    Message "Options"


    echo ""
    Message "1.  Debian 9"
    Message "2.  Debian 10"
   
   

    echo ""
    Message "#################################################################"
    echo ""
    read -p  "Please enter a number: " mono
    if [ "$mono" = "1" ]; then
    apt-get update && sudo apt-get upgrade
    apt install mono-complete -y
    Message "Mono has been installed"
    fi
    if [ "$mono" = "2" ]; then
    sudo apt update -y
    sudo apt install dirmngr gnupg apt-transport-https ca-certificates -y
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
    sudo sh -c 'echo "deb https://download.mono-project.com/repo/debian stable-buster main" > /etc/apt/sources.list.d/mono-official-stable.list'
    sudo apt update
    sudo apt install mono-complete -y
    Message "Mono has been installed"
    fi