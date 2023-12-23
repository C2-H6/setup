#!/bin/bash


USERNAME="C2-H6"
EMAIL="c2h6.dev@gmail.com"

declare -A updates=(
    ["ubuntu"]="apt -y update && sudo apt -y upgrade"
    ["manjaro-i3"]="pacman --noconfirm -Syu"
)

declare -A package_managers=(
  ["ubuntu"]="apt install -y"
  ["manjaro-i3"]="pacman -S --noconfirm"
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
    #config with "Settings Sync"
}

function startConfig {
    #done
    #configWebBrowser
    #configGit
    #configOther
    #configIde
    #configObsidian

    #configTerminal

    #configWindowManager
}


##----------------------------------------------- rest ------------------------------------------------##


get_os
#sys_upgrade

startConfig