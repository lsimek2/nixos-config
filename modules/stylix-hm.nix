{ pkgs, ... }: {

  stylix.enable = true;

  stylix.targets = {
    firefox.enable = true;
    nushell.enable = true;
  };
}
