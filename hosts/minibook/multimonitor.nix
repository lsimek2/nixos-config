{ pkgs }:

pkgs.writeShellScriptBin "multimonitor" ''
  #alias xrandr=${pkgs.xorg.xrandr}/bin/xrandr

      
  ${pkgs.xorg.xrandr}/bin/xrandr --output DSI-1 --mode 1200x1920 --rotate left

''
