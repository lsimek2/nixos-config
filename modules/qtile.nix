{ pkgs, pkgs-stable, ... }:
{
  services.xserver.enable = true;
  services.xserver.windowManager.qtile.enable = true;
  services.xserver.windowManager.qtile.extraPackages =
    python3Packages: with python3Packages; [
      qtile-extras
      pyxdg
      xdg
      dbus-next
    ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
  };

  #programs.xwayland.enable = true;

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
