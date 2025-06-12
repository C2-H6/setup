#!/bin/bash

C_YELLOW='\033[1;33m'  # ANSI escape code for yellow
C_RST='\033[0m'        # ANSI escape code to reset color

USERNAME="C2-H6"
EMAIL="c2h6.dev@gmail.com"


##----------------------------------------------- OS related information ------------------------------------------------##


function sys_upgrade {
    sudo pacman --noconfirm -Syu
}

function install {
    sudo pacman -S --noconfirm
}

function remove {
    sudo pacman -Rns
}


##----------------------------------------------- All program ------------------------------------------------##


function configOs {
        curl -fsSL https://github.com/C2-H6/setup/raw/main/i3/config-manjaro.sh -o ~/.i3/config

    #Download wallpaper 
    curl -o ~/.i3/wallpaper.png -fsSL https://github.com/C2-H6/setup/raw/main/wallpaper/1.png
    curl -o ~/.i3/hello.png -fsSL https://github.com/C2-H6/setup/raw/main/wallpaper/4.png

    #Download alt packages
    install picom
    install xfce4-power-manager
    install feh
    #police d'ecriture : xft:URWGothic-Book



#RAJOUTER delivery folder & remove useless part of os
}

function configTerminal {
    # Install terminal
    install xfce4-terminal 
    
    # Config xfce
    echo -e "${C_YELLOW}-----  Apparence :  -----${C_RST}"
    echo -e "${C_YELLOW}[--] : Transparent background${C_RST}"
    echo -e "${C_YELLOW}[o] : display menu bar${C_RST}"
    echo -e "${C_YELLOW}[o] : display border${C_RST}"
    echo -e "${C_YELLOW}Config xfce4, Press Enter when done...${C_RST}"
    read -p ""


    # Install zsh
    install zsh
    # Install Oh My Zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo -e "${C_YELLOW}write : [exit] once new shell open, Press Enter when understand...${C_RST}"
        sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    fi


    # Add alias
    echo "alias c='clear'" >> ~/.zshrc
}

function configNotion {
    if [ "$os" = "ubuntu" ]; then
        sudo apt install notion-app-enhanced
        sudo apt install notion-app
    elif [ "$os" = "manjaro" ]; then
        install yay
        yay -S notion-app
    fi

}

function configIde {
    if [ "$os" = "ubuntu" ]; then
        sudo ${install["ubuntu"]} code --classic
    elif [ "$os" = "manjaro" ]; then
        install code
    fi
    echo -e "${C_YELLOW}Setting Sync download and updtate, Press Enter when done...${C_RST}"
    read -p ""
}

function configOther {

    install discord
    #connect discord
    echo -e "${C_YELLOW}open : [DISCORD] and configure it, Press Enter when done...${C_RST}"
    read -p ""

    install spotify-launcher
    #connect spotify
    echo -e "${C_YELLOW}open : [SPOTIFY] and configure it, Press Enter when done...${C_RST}"
    read -p ""

    install code
    #connect sync to VScode
    echo -e "${C_YELLOW}Setting Sync download and updtate, Press Enter when done...${C_RST}"
    read -p ""
}

function configGit {
    install git
    install wl-clipboard

    git config --global user.name "$USERNAME"
    git config --global user.email "$EMAIL"

    ssh-keygen -t rsa -b 4096 -C "$EMAIL"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
    
    cat ~/.ssh/id_rsa.pub | wl-copy

    xdg-open "https://github.com/settings/keys"
    echo -e "${C_YELLOW}copy and past the token in [github], Press Enter when done...${C_RST}"
    read -p ""
}


function configWebBrowser {       

    #open firefox
    echo -e "${C_YELLOW}Open : [FIREFOX], Press Enter when done...${C_RST}"
    read -p ""

    #connect firefox
    xdg-open "https://accounts.firefox.com"
    echo -e "${C_YELLOW}Connection to [FIREFOX ACCOUNT], Press Enter when done...${C_RST}"
    read -p ""
    #connect google
    xdg-open "https://www.google.com/webhp"
    echo -e "${C_YELLOW}Connection to [GOOGLE], Press Enter when done...${C_RST}"
    read -p ""
    #connect google github
    xdg-open "https://github.com/login"
    echo -e "${C_YELLOW}Connection to [GITHUB], Press Enter when done...${C_RST}"
    read -p ""
    #connect google leetcode
    xdg-open "https://leetcode.com/accounts/signup/"
    echo -e "${C_YELLOW}Connection to [LEETCODE], Press Enter when done...${C_RST}"
    read -p ""
    #connect google openIA
    xdg-open "https://chat.openai.com"
    echo -e "${C_YELLOW}Connection to [OPEN-IA], Press Enter when done...${C_RST}"
    read -p ""
    #connect google deepSeek
    xdg-open "https://chat.deepseek.com"
    echo -e "${C_YELLOW}Connection to [DEEP-SEEK], Press Enter when done...${C_RST}"
    read -p ""
}

function startConfig {

    #configWebBrowser

    configGit

    #configOther

    #configNotion

    #configTerminal

    #configOs
}


##----------------------------------------------- rest ------------------------------------------------##


os="manjaro"
sys_upgrade

clear
startConfig

echo -e "${C_YELLOW}The PC will reboot, Press Enter when done...${C_RST}"
read -p ""
rm -- "$0"
sudo reboot
