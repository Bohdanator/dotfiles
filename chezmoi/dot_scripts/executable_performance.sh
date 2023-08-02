#!/bin/bash

if [ "$1" == "0" ]; then
    sudo sed -i 's/^CPU_SCALING_GOVERNOR_ON_AC=performance$/CPU_SCALING_GOVERNOR_ON_AC=powersave/' /etc/tlp.conf
    sudo tlp start > /dev/null 2>&1

fi

if [ "$1" == "1" ]; then
    sudo sed -i 's/^CPU_SCALING_GOVERNOR_ON_AC=powersave$/CPU_SCALING_GOVERNOR_ON_AC=performance/' /etc/tlp.conf
    sudo tlp start > /dev/null 2>&1
fi
