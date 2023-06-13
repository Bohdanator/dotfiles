#!/bin/bash

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
blueman-applet &
nm-applet --indicator &
wl-paste --watch clipman store --no-persist &

gsettings set org.gnome.desktop.interface gtk-theme 'Arc-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.interface font-name 'Noto Sans 10'

systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP
exec hash dbus-update-activation-environment 2>/dev/null && dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP DBUS_SESSION_BUS_ADDRESS XAUTHORITY
