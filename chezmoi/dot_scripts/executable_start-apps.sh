#!/bin/bash

~/.scripts/toolwait.py -w Alacritty -m scratch0 -- alacritty
swaymsg 'move scratchpad'

~/.scripts/toolwait.py -w Alacritty -m scratch1 -- alacritty
swaymsg 'move scratchpad'

~/.scripts/toolwait.py -w Alacritty -m scratch2 -- alacritty -e ipython
swaymsg 'move scratchpad'

~/.scripts/toolwait.py -w Alacritty -m scratch4 -- alacritty -e htop
swaymsg 'move scratchpad'

swaymsg 'workspace --no-auto-back-and-forth "1:1 󰈹 "'
~/.scripts/toolwait.py firefox

swaymsg 'workspace --no-auto-back-and-forth "2:2 󰈹 "'
#

~/.scripts/start-code.sh

swaymsg 'workspace --no-auto-back-and-forth "11:-  "'
~/.scripts/toolwait.py -w org.telegram.desktop -- bash -c 'telegram-desktop &'

swaymsg 'workspace --no-auto-back-and-forth "12:= 󰒱 "'
~/.scripts/toolwait.py -w Slack -- slack --ozone-platform-hint=auto
