#!/bin/bash


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


##----------------------------------------------- salopette ------------------------------------------------##


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


##----------------------------------------------- other ------------------------------------------------##


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

function configWebBrowser {
    install opera

    if [ -n "$BROWSER" ]; then
    BROWSER="opera.desktop"
    fi
    xdg-settings set default-web-browser "$BROWSER"

    #connect google
    xdg-open "https://www.google.com/webhp"
    read -p "[GOOGLE], Press Enter when done..."
    #connect opera
    xdg-open "https://auth.opera.com/account/authenticate/email"
    read -p "[OPERA], Press Enter when done..."
    #connect google github
    xdg-open "https://github.com/login"
    read -p "[GITHUB], Press Enter when done..."
    #connect google leetcode
    xdg-open "https://leetcode.com/accounts/signup/"
    read -p "[LEETCODE], Press Enter when done..."
    #connect google openIA
    xdg-open "https://chat.openai.com"
    read -p "[OPEN-IA], Press Enter when done..."
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

function configTerminal { #review after all finished
    # install terminal
    install xfce4-terminal
    
    # config xfce
    # transparent
    # pas de bar en haut
    # police xft:URWGothic-Book
    # pas de bar coulissante de cote


    # choose shell
    install zsh
    curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh > oh-my-zsh.sh
    sed -i "s:env zsh:exit:g" oh-my-zsh.sh
    chmod 755 oh-my-zsh.sh
    ./oh-my-zsh.sh
    rm oh-my-zsh.sh

    # add alias
    echo "alias c='clear'" >> ~/.zshrc
    source ~/.zshrc
}

function configIde {
    install code #verify next install
    code
    read -p "Setting Sync download and updtate, Press Enter when done..."
}

function configGraphical {

}

function configOs {
    # Download wallapper
    imgPath="~/.i3/wallpaper.jpg"
    curl -fsSL https://github.com/C2-H6/setup/blob/main/wallpaper.jpg >  $imgPath

    #Download alt packages
    install picom
    install xfce4-power-manager
    #police d'ecriture : xft:URWGothic-Book


    #install logiciel tier
    if [ "$os" == "manjaro" ]; then
        echo "Le système d'exploitation est Manjaro."

        install i3-wm # pas le meme nom par prog

        curl -fsSL https://github.com/C2-H6/setup/raw/main/config.sh -o ~/.i3/config

    elif [ "$os" == "ubuntu" ]; then
        echo "Le système d'exploitation est Ubuntu."

        install i3-wm # pas le meme nom par prog

    fi
}

function startConfig {
    #done
    #configWebBrowser
    #configGit
    #configOther
    #configIde
    #configObsidian

    configOS
    #configTerminal
    
}


##----------------------------------------------- rest ------------------------------------------------##


get_os
#sys_upgrade

startConfig

#rm -- "$0"
#sudo reboot