#!/bin/bash

if [ "$1" == "d" ]; then
    gsettings set org.gnome.desktop.interface color-scheme prefer-dark
    gsettings set org.gnome.desktop.interface gtk-theme 'Arc-Dark'
    gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
    sed -i -e 's/"workbench.colorTheme": ".*"/"workbench.colorTheme": "Default Dark Modern"/g' "$HOME/.config/Code/User/settings.json"
fi

if [ "$1" == "l" ]; then
    gsettings set org.gnome.desktop.interface color-scheme prefer-light
    gsettings set org.gnome.desktop.interface gtk-theme 'Arc'
    gsettings set org.gnome.desktop.interface icon-theme 'Papirus'
    sed -i -e 's/"workbench.colorTheme": ".*"/"workbench.colorTheme": "Default Light Modern"/g' "$HOME/.config/Code/User/settings.json"
fi
