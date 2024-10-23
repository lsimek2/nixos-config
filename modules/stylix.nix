{ stylix, pkgs, ... }:
{
  stylix.enable = true;

  stylix.image = ../users/carjin/desktop.jpg;

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyodark.yaml";

  stylix.cursor = {
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ-Black";
    size = 10;
  };

  stylix.fonts = {
    monospace = {
      package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
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
      popups = 9;
    };

  };

  stylix.opacity = {
    applications = 1.0;
    terminal = 0.8;
    desktop = 1.0;
    popups = 0.6;
  };

  stylix.targets = {
    # commented lines should go to home manager
    #	firefox.enable = true;
    #	nushell.enable = true;
  };
}
