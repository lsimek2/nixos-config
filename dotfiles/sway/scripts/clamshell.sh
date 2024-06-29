#!/usr/bin/bash
if cat /proc/acpi/button/lid/LID/state | grep -q open; then
    swaymsg output <DSI-1> enable
else
    swaymsg output <DSI-1> disable
fi
