{ pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.windowManager.qtile.enable = true;

  environment.systemPackages = with pkgs; [
    wofi
    dunst
    caffeine-ng
    mypy
    pavucontrol
  ];

  services.xserver.xkb.variant = "us";
  services.xserver.xkb.layout = "hr";
}
