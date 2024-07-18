#!/usr/bin/env nu

def run [name: string, ...args: string] {
  if (ps | where name =~ $name | length | $in == 0) {
    ^pueue add $name ...$args
  }
}

^pueue clean
^pueue parallel 1024

if ($env.XDG_SESSION_TYPE == "wayland") {
    if (hostname | $in == "minibook") {
    	run rotate-screen
    	run swaybg "-i" ~/Pictures/wallhaven-8586my.png "-m" fit
    }
    if (hostname | $in == "victus") {
        run wlr-randr "--output" DP-2 "--mode" 1920x1080@143.854996 "--pos" "0,0"
        run swaybg "-i" ~/Pictures/to_sh250_ooh_01_01_wip002.jpg "-m" fill
        
    }
    run dunst
    run rm ~/.gtkrc-2.0.backup
    
}


if ($env.XDG_SESSION_TYPE == "x11") {

    run nm-applet
#    run blueman-applet
    run flameshot
    run dunst

    run picom "--config" ".config/picom/picom.conf"

    run System/lolmouse
}

# run discord "--start-minimized"
run telegram-desktop "-startintray"
run signal-desktop "--start-in-tray"
run element-desktop


run kmonad ~/.config/kmonad/mech.kbd
run nextcloud

run caffeine
