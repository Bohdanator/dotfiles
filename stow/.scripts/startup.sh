#!/bin/bash

touchpad_id=$(xinput --list | grep -i "Touchpad" | xargs -n 1 | grep "id=" | sed 's/id=//g')
natural_scrolling_code=$(xinput --list-props "$touchpad_id" | grep "Natural Scrolling" | awk '{print $5}' |  grep -o '[0-9]\+')
xinput --set-prop "$touchpad_id" "$natural_scrolling_code" 1
tapping_code=$(xinput --list-props "$touchpad_id" | grep "Tapping" | awk '{print $4}' |  grep -o '[0-9]\+')
xinput --set-prop "$touchpad_id" "$tapping_code" 1

xset m 20/10 10 r rate 180 20 b off

gxkb &
setxkbmap -layout 'us,sk(qwerty)'
setxkbmap -option 'grp:win_space_toggle'

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
xfce4-power-manager &
pa-applet &
nm-applet &
parcellite &

xrandr --output eDP1 --gamma 0.9:1.0:0.8
xrandr --output eDP1 --auto --primary --output DP1 --off --output HDMI1 --off
sleep 1
nitrogen --restore
sleep 1
picom -b
