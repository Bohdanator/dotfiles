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
    sed -i -e 's/.*theme-.*/"~\/.config\/alacritty\/theme-dark.toml",/g' "$HOME/.config/alacritty/alacritty.toml"
    sed -i -e 's/colors=.*/colors=colors-dark/g' "$HOME/.config/wofi/config"
    sed -i -e 's/@import "theme-.*";/@import "theme-dark.css";/g' "$HOME/.config/waybar/style.css"
    swaymsg reload
fi

if [ "$INPUT" == "1" ]; then
    gsettings set org.gnome.desktop.interface color-scheme prefer-light
    gsettings set org.gnome.desktop.interface gtk-theme 'Arc'
    gsettings set org.gnome.desktop.interface icon-theme 'Papirus'
    sed -i -e 's/"workbench.colorTheme": ".*"/"workbench.colorTheme": "Default Light Modern"/g' "$HOME/.config/Code/User/settings.json"
    sed -i -e 's/.*theme-.*/"~\/.config\/alacritty\/theme-light.toml",/g' "$HOME/.config/alacritty/alacritty.toml"
    sed -i -e 's/colors=.*/colors=colors-light/g' "$HOME/.config/wofi/config"
    sed -i -e 's/@import "theme-.*";/@import "theme-light.css";/g' "$HOME/.config/waybar/style.css"
    swaymsg reload
fi
