{ pkgs, ... }:
{

  stylix.enable = true;

  stylix.targets = {
    firefox.enable = true;
    # nushell.enable = false;
    alacritty.enable = true;
    vesktop.enable = true;
    mako.enable = true;
  };
}
