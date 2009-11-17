#!/bin/bash

# Set these to your outputs
INT=LVDS1
EXT=VGA1

XRANDR=$(xrandr)

get_state() {
    local output=$1
    local state=$(echo "$XRANDR" | grep $output)

    if [[ $state =~ [0-9]+x[0-9]+ ]]; then
        echo on
    else
        echo off
    fi
}

INT_STATE=$(get_state $INT)
EXT_STATE=$(get_state $EXT)

if [[ $INT_STATE = "on" && $EXT_STATE = "off" ]]; then
    # Switch to mirror
    xrandr --output $EXT --auto
elif [[ $INT_STATE = "on" && $EXT_STATE = "on" ]]; then
    # Switch to external only
    xrandr --output $INT --off
else 
    # Switch to internal only
    xrandr --output $INT --auto --output $EXT --off
fi
