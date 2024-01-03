#!/bin/bash

C_YELLOW='\033[1;33m'  # ANSI escape code for yellow
C_RST='\033[0m'        # ANSI escape code to reset color

USERNAME="C2-H6"
EMAIL="c2h6.dev@gmail.com"

declare -A updates=(
    ["ubuntu"]="apt -y update && sudo apt -y upgrade"
    ["manjaro"]="pacman --noconfirm -Syu"
)

declare -A package_managers=(
  ["ubuntu"]="apt install -y"
  ["manjaro"]="pacman -S --noconfirm"
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
    local update="${updates[$os]}"
    sudo $update
}

function install {
    local package_manager="${package_managers[$os]}"
    sudo $package_manager "$1"
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
    read -p "Press Enter when done..."
}



function configOther {
    #connect discord
    install discord
    discord
}

function configObsidian {
    install obsidian
    install -S noto-fonts-emoji

    git clone git@github.com:C2-H6/obsidianBackup.git
    obsidian
}

function configTerminal { #when open zsh rc don't continue the script
    # install terminal
    install xfce4-terminal
    
    # config xfce
    # transparent
    # pas de bar en haut
    # police xft:URWGothic-Book
    # pas de bar coulissante de cote


    # choose shell
    # Install Zsh
    sudo apt install zsh

    # Install Oh My Zsh
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    # Set Zsh as the default shell
    chsh -s $(which zsh)

    # add alias
    echo "alias c='clear'" >> ~/.zshrc
    source ~/.zshrc
}

function configIde {
    install code
    code
    read -p "Setting Sync download and updtate, Press Enter when done..."
}

function configOs {
    #Download i3, amd wallpaper
    curl -fsSL https://github.com/C2-H6/setup/raw/main/i3/config.sh -o ~/.i3/config
    curl -o ~/.i3/wallpaper.png -fsSL https://github.com/C2-H6/setup/raw/main/wallpaper/1.png
    curl -o ~/.i3/hello.png -fsSL https://github.com/C2-H6/setup/raw/main/wallpaper/4.png

    #Download alt packages
    install picom
    install xfce4-power-manager
    #police d'ecriture : xft:URWGothic-Book



    #install i3
    if [ "$os" == "manjaro" ]; then
        echo "Le système d'exploitation est Manjaro."

        install i3-wm # pas le meme nom par prog

    elif [ "$os" == "ubuntu" ]; then
        echo "Le système d'exploitation est Ubuntu."
        install i3
    fi
}

function configWebBrowser {
    install opera

    if [ -n "$BROWSER" ]; then
    export BROWSER=firefox
    fi
    xdg-settings set default-web-browser opera.desktop


    #connect google
    xdg-open "https://www.google.com/webhp"
    echo -e "${C_YELLOW}[GOOGLE], Press Enter when done...${C_RST}"
    read -p ""
    xdg-open "https://auth.opera.com/account/authenticate/email"
    echo -e "${C_YELLOW}[OPERA], Press Enter when done...${C_RST}"
    read -p ""
    #connect google github
    xdg-open "https://github.com/login"
    echo -e "${C_YELLOW}[GITHUB], Press Enter when done...${C_RST}"
    read -p ""
    #connect google leetcode
    xdg-open "https://leetcode.com/accounts/signup/"
    echo -e "${C_YELLOW}[LEETCODE], Press Enter when done...${C_RST}"
    read -p ""
    #connect google openIA
    xdg-open "https://chat.openai.com"
    echo -e "${C_YELLOW}[OPEN-IA], Press Enter when done...${C_RST}"
    read -p ""
}

function startConfig {
    configWebBrowser
    #configTerminal
    #configGit
    #configOther
    #configIde
    #configObsidian

    #configOS
}


##----------------------------------------------- rest ------------------------------------------------##


get_os
sys_upgrade

startConfig

#rm -- "$0"
#sudo reboot