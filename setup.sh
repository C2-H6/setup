#!/bin/bash

USERNAME="C2-H6"
EMAIL="c2h6.dev@gmail.com"

declare -A updates=(
    ["ubuntu"]="apt -y update && sudo apt -y upgrade"
    ["manjaro-i3"]="pacman --noconfirm -Syu"
)

# ne pas re telecharger si deja la
declare -A package_managers=(
  ["ubuntu"]="apt install -y"
  ["manjaro-i3"]="pacman -S"
)


##----------------------------------------------- salopette ------------------------------------------------##


function get_os {
    if command -v apt-get &> /dev/null; then
        os="ubuntu"
    elif command -v pacman &> /dev/null; then
        os="manjaro-i3"
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


##----------------------------------------------- temporary ------------------------------------------------##


wallpaper="https://raw.githubusercontent.com/C2-H6/Initialisation/main/wallpaper.jpg"

function graphical-i3 {
    sudo pacman -S feh
    feh --bg-scale $wallpaper


    #lock i3 lock fond d'ecran pc
    #ecran de verouillage
    #fond txt enlever conki
    #enlever bar en bas sans window m et 
}

function usage-i3 {

    # N raccourcis discord/obsidian/opera/ide/explorateur/fichier
    #terminal raccourcis
    sed -i 's/bindsym $mod+Return exec terminal/bindsym $mod+Return exec xfce4-terminal/g' ~/.i3/config


    # exploreateur de fichier

    #i3 config
    #reload i3 config
}


##----------------------------------------------- other ------------------------------------------------##


function config_ide {
    install code
    #config header2
    #tab = space
}

function configScndBrain {
    install obsidian
    install -S noto-fonts-emoji
    #clone obsidian
    #conect obsidian
}



function config_other {
    install discord
    install spotify
    #connect discord
    #spotify, bluthooth, pilote son
}

function config_terminal {
    # terminal + shell + alias + config xfce

    install xfce4-terminal
    install zsh
    #curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh > oh-my-zsh.sh
    #sed -i "s:env zsh:exit:g" oh-my-zsh.sh
    #chmod 755 oh-my-zsh.sh
    #./oh-my-zsh.sh
    #rm oh-my-zsh.sh
    
    echo "alias c='clear'" >> ~/.zshrc
    source ~/.zshrc
}

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
    install opera #configure addon under opera account

    if [ -n "$BROWSER" ]; then
    BROWSER="opera.desktop"
    fi
    xdg-settings set default-web-browser "$BROWSER"

    #connect opera
    xdg-open "https://github.com/settings/keys"
    read -p "Press Enter when done..."

    #connect google ethan
    xdg-open "https://github.com/settings/keys"
    read -p "Press Enter when done..."
    #connect google C2H6
    xdg-open "https://github.com/settings/keys"
    read -p "Press Enter when done..."

    #connect google github
    xdg-open "https://github.com/settings/keys"
    read -p "Press Enter when done..."
    #connect google leetcode
    xdg-open "https://github.com/settings/keys"
    read -p "Press Enter when done..."
    #connect google openIA
    xdg-open "https://github.com/settings/keys"
    read -p "Press Enter when done..."
}

function startConfig {
    configWebBrowser

    #done
    #configGit


    #configWindowManager
    #2config_ide

    #3config_terminal
    #4config_other
}


##----------------------------------------------- rest ------------------------------------------------##


get_os
#sys_upgrade

startConfig