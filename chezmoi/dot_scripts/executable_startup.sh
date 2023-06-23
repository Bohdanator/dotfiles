#!/bin/bash

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
blueman-applet &
nm-applet --indicator &
wl-paste --watch clipman store --no-persist &

~/.scripts/theme.sh d
gsettings set org.gnome.desktop.interface font-name 'Noto Sans 10'

systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP
hash dbus-update-activation-environment 2>/dev/null && dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP DBUS_SESSION_BUS_ADDRESS XAUTHORITY
