#!/bin/bash

INPUT="$1"

if [ "$INPUT" == "t" ]; then
    if [[ $(gsettings get org.gnome.desktop.interface gtk-theme) =~ [Dd]ark ]]; then
        INPUT="1"
    else
        INPUT="0"
    fi
fi

if [ "$INPUT" == "0" ]; then
    gsettings set org.gnome.desktop.interface color-scheme prefer-dark
    gsettings set org.gnome.desktop.interface gtk-theme 'Arc-Dark'
    gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
    sed -i -e 's/"workbench.colorTheme": ".*"/"workbench.colorTheme": "Default Dark Modern"/g' "$HOME/.config/Code/User/settings.json"
fi

if [ "$INPUT" == "1" ]; then
    gsettings set org.gnome.desktop.interface color-scheme prefer-light
    gsettings set org.gnome.desktop.interface gtk-theme 'Arc'
    gsettings set org.gnome.desktop.interface icon-theme 'Papirus'
    sed -i -e 's/"workbench.colorTheme": ".*"/"workbench.colorTheme": "Default Light Modern"/g' "$HOME/.config/Code/User/settings.json"
fi
