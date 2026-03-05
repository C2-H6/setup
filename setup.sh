#!/bin/bash

C_YELLOW='\033[1;33m'  # ANSI escape code for yellow
C_RED='\033[1;31m'     # ANSI escape code for red
C_RST='\033[0m'        # ANSI escape code to reset color

USERNAME="C2-H6"
EMAIL="c2h6.dev@gmail.com"


##----------------------------------------------- OS related information ------------------------------------------------##


function sys_upgrade {
    sudo pacman --noconfirm -Syu "$@"
}

function install {
    sudo pacman -S --noconfirm "$@"
}

function uninstall {
    sudo pacman -Rns "$@"
}


##----------------------------------------------- All program ------------------------------------------------##


function configOs {
    install topgrade
    git clone --depth=1 https://github.com/C2-H6/setup.git /tmp/setup && rm -rf ~/.config/sway && cp -r /tmp/setup/sway ~/.config/sway
    mkdir "$HOME/delivery"
    rm -rf ~/Desktop ~/Music ~/Templates ~/Public ~/Videos
}

function configTerminal {
    install tree

    # Install Oh My Zsh
    if [ ! -d "$HOME/.config/zsh/ohmyzsh" ]; then
        echo -e "${C_YELLOW}[WARNING] write : [${C_RED}exit${C_YELLOW}] once new shell open, Press Enter when understand...${C_RST}"
        sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    fi

    # Add alias
    echo "alias c='clear'" >> "$HOME/.config/zsh/ohmyzsh/oh-my-zsh.sh"
    echo "plugins=(git zsh-autosuggestions)" >> "$HOME/.config/zsh/ohmyzsh/oh-my-zsh.sh"
    echo "source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> "$HOME/.config/zsh/ohmyzsh/oh-my-zsh.sh"
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
    #connect CODE-OSS
    echo -e "${C_YELLOW}open : [CODE_OSS] and configure it, Press Enter when done...${C_RST}"
    read -p ""

    yay -S --noconfirm notion-app-electron
    #connect notion
    curl -fsSL https://raw.githubusercontent.com/C2-H6/setup/main/config.toml -o ~/.config/sworkstyle/config.toml
    echo -e "${C_YELLOW}open : [NOTION] and configure it, Press Enter when done...${C_RST}"
    read -p ""

    yay -S --noconfirm ledger-live-desktop
    #fix for Manjaro
    wget -q -O - https://raw.githubusercontent.com/LedgerHQ/udev-rules/master/add_udev_rules.sh | sudo bash
    echo -e "${C_YELLOW}open : [LEDGER] and configure it, Press Enter when done...${C_RST}"
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

    #connect google
    xdg-open "https://www.google.com/webhp"
    echo -e "${C_YELLOW}Connection to [GOOGLE], Press Enter when done...${C_RST}"
    read -p ""
    #connect bitWarden
    xdg-open "https://vault.bitwarden.com/#/login"
    echo -e "${C_YELLOW}Connection to [BITWARDEN], Press Enter when done...${C_RST}"
    #connect firefox
    xdg-open "https://accounts.firefox.com"
    echo -e "${C_YELLOW}Connection to [FIREFOX ACCOUNT], Press Enter when done...${C_RST}"
    echo -e "${C_YELLOW}Simple Tab : [Home] | [Travail] | [Dev01] | [Dev02] | [Manga]${C_RST}"
    #echo -e "${C_YELLOW}You need to change some of the firefox things like the Bookmarks bars...${C_RST}"
    read -p ""
    #connect google github
    xdg-open "https://github.com/login"
    echo -e "${C_YELLOW}Connection to [GITHUB], Press Enter when done...${C_RST}"
    read -p ""
    #connect google openIA
    xdg-open "https://chat.openai.com"
    echo -e "${C_YELLOW}Connection to [OPEN-IA], Press Enter when done...${C_RST}"
    read -p ""
    #connect google Claude
    xdg-open "https://claude.ai/new"
    echo -e "${C_YELLOW}Connection to [CLAUDE], Press Enter when done...${C_RST}"
    read -p ""
    #connect google Finary
    xdg-open "https://app.finary.com/v2/login"
    echo -e "${C_YELLOW}Connection to [FINARY], Press Enter when done...${C_RST}"
    read -p ""
}

function startConfig {

    configWebBrowser
    configGit
    configOther

    configTerminal
    configOs
}


##----------------------------------------------- rest ------------------------------------------------##


sys_upgrade

clear
startConfig

echo -e "${C_YELLOW}The PC will reboot, Press Enter when done...${C_RST}"
read -p ""
rm -- "$0"
sudo reboot