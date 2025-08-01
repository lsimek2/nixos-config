{
  pkgs,
  lib,
  ...
}:
{
  stylix.enable = true;

  stylix.image = lib.mkDefault ../users/carjin/desktop-sunset.jpg;

  # specialisation.dark.configuration = {
  #   stylix.image = ../users/carjin/desktop.jpg;
  stylix.polarity = "dark";
  #   stylix.opacity.terminal = 1.0;
  # };

  stylix.cursor = {
    package = pkgs.vanilla-dmz;
    name = "DMZ-Black";
    # name = "Vanilla-DMZ-Black";
    size = 10;
  };

  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font Mono";
    };

    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };

    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };

    sizes = {
      applications = 12;
      terminal = 10;
      desktop = 10;
      popups = 10;
    };

  };

  stylix.opacity = {
    applications = 1.0;
    terminal = lib.mkDefault 0.9;
    desktop = 1.0;
    popups = 0.6;
  };

  stylix.targets = {
    # commented lines should go to home manager
    #	firefox.enable = true;
    #	nushell.enable = true;
  };
}
