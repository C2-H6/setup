#!/bin/bash

C_YELLOW='\033[1;33m'  # ANSI escape code for yellow
C_RST='\033[0m'        # ANSI escape code to reset color

USERNAME="C2-H6"
EMAIL="c2h6.dev@gmail.com"

declare -A updates=(
    ["ubuntu"]="apt -y update && sudo apt -y upgrade"
    ["ubuntuV2"]="snap refresh"
    ["manjaro"]="pacman --noconfirm -Syu"
)

declare -A package_managers=(
    ["ubuntu"]="apt install -y"
    ["ubuntuV2"]="snap install"
    ["manjaro"]="pacman -S --noconfirm"
)

declare -A remove=(
    ["ubuntu"]="apt purge"
    ["manjaro"]="sudo pacman -Rns" 
)


##----------------------------------------------- OS related information ------------------------------------------------##


function get_os {
    if command -v apt-get &> /dev/null; then
        os="ubuntu"
    elif command -v pacman &> /dev/null; then
        os="manjaro"
    else
        echo "Your OS is not supported."
        return 1
    fi
}

function sys_upgrade {
    sudo ${updates[$os]}
}

function install {
    sudo ${package_managers[$os]} "$1"
}

function remove {
    sudo ${remove[$os]} "$1"
}


##----------------------------------------------- All program ------------------------------------------------##


function configGit {
    install git

    git config --global user.name "$USERNAME"
    git config --global user.email "$EMAIL"

    ssh-keygen -t rsa -b 4096 -C "$EMAIL"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
    
    cat ~/.ssh/id_rsa.pub

    xdg-open "https://github.com/settings/keys"
    echo -e "${C_YELLOW}copy and past the token in [github], Press Enter when done...${C_RST}"
    read -p ""
}

function configOther {
    #connect discord
    install discord
    echo -e "${C_YELLOW}open : [DISCORD] and configure it, Press Enter when done...${C_RST}"
    read -p ""
}

function configObsidian {
    install obsidian
    install -S noto-fonts-emoji

    git clone git@github.com:C2-H6/obsidianBackup.git
    echo -e "${C_YELLOW}open : [OBSIDIAN]  and configure it, Press Enter when done...${C_RST}"
    read -p ""
}

function configIde {
    install code
    code
    echo -e "${C_YELLOW}Setting Sync download and updtate, Press Enter when done...${C_RST}"
    read -p ""
}

function configOs {
    #Download i3, and wallpaper
    curl -fsSL https://github.com/C2-H6/setup/raw/main/i3/config.sh -o ~/.i3/config
    curl -o ~/.i3/wallpaper.png -fsSL https://github.com/C2-H6/setup/raw/main/wallpaper/1.png
    curl -o ~/.i3/hello.png -fsSL https://github.com/C2-H6/setup/raw/main/wallpaper/4.png

    #Download alt packages
    install picom
    install xfce4-power-manager
    install feh
    #police d'ecriture : xft:URWGothic-Book

    if [ "$os" = "ubuntu" ]; then
        install i3
    fi
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



    # Install zsh, Oh My Zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh > oh-my-zsh.sh
      sed -i "s:env zsh:exit:g" oh-my-zsh.sh
        chmod 755 oh-my-zsh.sh
        ./oh-my-zsh.sh
        rm oh-my-zsh.sh
        chsh $USER -s /usr/bin/zsh
        

        #sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        #source <(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)
        #exit
    fi


    # Add alias
    echo "alias c='clear'" >> ~/.zshrc
}

function configWebBrowser {
    # Install opera and make it the default web browser
    if [ "$os" = "ubuntu" ]; then
        sudo sh -c 'echo "deb http://deb.opera.com/opera/ stable non-free" >> /etc/apt/sources.list.d/opera.list'
        sudo sh -c 'wget -O - http://deb.opera.com/archive.key | apt-key add -'
        sudo ${updates[$os]}
        install opera-stable
        xdg-settings set default-web-browser opera.desktop
    elif [ "$os" = "manjaro" ]; then
        install opera
        remove palemoon        
        xdg-settings set default-web-browser opera.desktop
    fi

    #open opera
    echo -e "${C_YELLOW}Open : [OPERA], Press Enter when done...${C_RST}"
    read -p ""

    #connect google
    xdg-open "https://www.google.com/webhp"
    echo -e "${C_YELLOW}Connection to [GOOGLE], Press Enter when done...${C_RST}"
    read -p ""
    #connect opera
    xdg-open "https://auth.opera.com/account/authenticate/email"
    echo -e "${C_YELLOW}Connection to [OPERA], Press Enter when done...${C_RST}"
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
}

function startConfig {
    #configWebBrowser
    #configGit
    #configOther
    #configIde
    #configObsidian

    configTerminal
    #configOs
}


##----------------------------------------------- rest ------------------------------------------------##


get_os
sys_upgrade

startConfig

echo -e "${C_YELLOW}End of the setup, Press Enter when done...${C_RST}"
read -p ""
    #rm -- "$0"
    #sudo reboot
