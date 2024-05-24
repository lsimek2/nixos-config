{pkgs, ...}:
{
  services.xserver.enable = true;
  services.xserver.windowManager.qtile.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  
  environment.systemPackages = with pkgs; [
    rofi
    picom
    flameshot
    dunst
    caffeine-ng
    mypy
    pavucontrol
  ];

  services.xserver.xkb.variant = "us";
  services.xserver.xkb.layout = "hr";
}
  
