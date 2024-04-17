#!/bin/bash

cd ~/Pictures

if [ "$1" == "all" ]; then
    grim
    notify-send 'all screens captured'
fi

if [ "$1" == "screen" ]; then
    SCREEN=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
    grim -o "$SCREEN"
    notify-send 'focused screen captured'
fi

if [ "$1" == "window" ]; then
    WINDOW=$(swaymsg -t get_tree | jq -r '.. | (.nodes? // empty)[] | if (.focused) then select(.focused) | "\(.rect.x),\(.rect.y) \(.rect.width)x\(.rect.height)" else (.floating_nodes? // empty)[] | select(.visible) | select(.focused) | "\(.rect.x),\(.rect.y) \(.rect.width)x\(.rect.height)" end')
    grim -g "$WINDOW"
    notify-send 'focused window captured'
fi

if [ "$1" == "select" ]; then
    SELECTION=$(slurp -c '#ff0000ff')
    grim -g "$SELECTION"
    notify-send 'selection captured'
fi

if [ "$1" == "edit" ] || [ "$2" == "edit" ]; then
    INPUT=$(ls -t | head -1)
    OUTPUT=$(date '+%Y%m%d_%Hh%Mm%Ss')_satty.png
    satty -f "$INPUT" --output-filename "$OUTPUT"
fi

if [ "$1" == "record" ]; then
    SELECTION=$(slurp -c '#ff0000ff')
    OUTPUT=$(date '+%Y%m%d_%Hh%Mm%Ss')_wf-recorder.mp4
    wf-recorder -f "$OUTPUT" -g " $SELECTION"
fi
