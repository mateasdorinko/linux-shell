#!/bin/bash

install_nala() {
    sudo apt install nala
}

install_basics() {
    sudo nala install git
    sudo nala install neofetch
    sudo nala install glances
    sudo nala install curl
}

install_ufw() {
    sudo nala install ufw
    sudo ufw allow 22/tcp comment "SSH"

    sudo systemctl start ufw
    sudo systemctl enable ufw
}

install_flatpak_app() {
    read -p "Do you want to install $1? (y/n) " yn

    case $yn in 
        [yY] ) flatpak install flathub -y $1;;
        [nN] ) ;;
        * ) echo "Invalid response";
            install_flatpak_app $1;;
    esac
}

install_flatpak_browser_apps() {
    echo
    echo ===========================================
    echo INSTALL FLATPAK BROWSER APPS
    echo ===========================================

    install_flatpak_app org.mozilla.firefox
    install_flatpak_app com.google.Chrome
    install_flatpak_app com.microsoft.Edge
    install_flatpak_app com.brave.Browser
}

install_flatpak_dev_apps() {
    echo
    echo ===========================================
    echo INSTALL DEV APPS
    echo ===========================================

    install_flatpak_app com.visualstudio.code
    install_flatpak_app com.jetbrains.Rider
    install_flatpak_app com.jetbrains.WebStorm
    install_flatpak_app com.microsoft.AzureStorageExplorer
    # install_flatpak_app com.microsoft.AzureDataStudio
    install_flatpak_app com.getpostman.Postman
    install_flatpak_app org.wireshark.Wireshark
}

install_flatpak_productivity_apps() {
    echo
    echo ===========================================
    echo INSTALL PRODUCTIVITY APPS
    echo ===========================================

    install_flatpak_app md.obsidian.Obsidian
    install_flatpak_app com.todoist.Todoist
    install_flatpak_app org.libreoffice.LibreOffice
    install_flatpak_app com.slack.Slack
}

install_flatpak_media_apps() {
    echo
    echo ===========================================
    echo INSTALL MEDIA APPS
    echo ===========================================

    install_flatpak_app org.videolan.VLC
    install_flatpak_app tv.plex.PlexDesktop
    install_flatpak_app com.makemkv.MakeMKV
}

install_flatpak_utility_apps() {
    echo
    echo ===========================================
    echo INSTALL UTILITY APPS
    echo ===========================================

    install_flatpak_app org.remmina.Remmina
    install_flatpak_app org.inkscape.Inkscape
    install_flatpak_app org.gimp.GIMP
    install_flatpak_app com.github.zocker_160.SyncThingy
}

install_flatpak() {
    sudo nala install flatpak
    sudo nala install gnome-software-plugin-flatpak

    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

    sudo nala update
    sudo nala upgrade

    install_flatpak_browser_apps
    install_flatpak_dev_apps
    install_flatpak_productivity_apps
    install_flatpak_media_apps
    install_flatpak_utility_apps
}

setup_ssh_key() {
    cd ~/
    mkdir .ssh
    cd .ssh

    ssh-keygen -t ed25519
}

run() {
    install_nala

    install_basics
    install_ufw
    install_flatpak

    sudo nala autoremove

    setup_ssh_key
}

run

echo
echo ===========================================
echo FINISHED!!
echo ===========================================
