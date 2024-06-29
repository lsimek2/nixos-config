{ stylix, pkgs, ... }: {
  stylix.enable = true;

  stylix.image = pkgs.fetchurl {
    url = "https://images.squarespace-cdn.com/content/v1/536ce6b7e4b023ebcb5fc045/1534918235616-LJ5FTYQDFNLS6R12IA6I/to_sh250_ooh_01_01_wip002.jpg?format=2500w";
    sha256 = "LTD8jdG0ZSOB81SaDrTo75yFvYZcJ3LQaIRnZDNfJog=";
  };

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
    nixvim.enable = true;
    #	nushell.enable = true;
  };
}
