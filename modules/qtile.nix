{ pkgs, pkgs-stable, ... }:
{
  services.xserver.enable = true;
  services.xserver.windowManager.qtile.enable = true;

  environment.systemPackages = with pkgs; [
    dunst
    caffeine-ng
    mypy
    pavucontrol
    
    #x11
    rofi
    picom
    flameshot
    
    #wayland
    wofi
    swaybg
    wlr-randr
  ];

  services.xserver.xkb.variant = "us";
  services.xserver.xkb.layout = "hr";
}
  
