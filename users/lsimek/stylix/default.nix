#TODO: get rid of stylix
{
  pkgs,
  pkgs-unstable,
  config,
  inputs,
  lib,
  ...
}:
{
  # imports = [ inputs.stylix.homeManagerModules.stylix ];

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = import ./scheme.nix;

    cursor = {
      name = "DMZ-Black";
      size = 10;
      package = pkgs.vanilla-dmz;
    };

    fonts = {
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-color-emoji;
      };
      monospace = {
        name = "JetBrains Mono";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };
      sansSerif = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };
      serif = {
        name = "Noto Serif";
        package = pkgs.noto-fonts;
      };

      sizes = {
        terminal = 13;
        applications = 11;
      };

    };

    opacity = {
      applications = 1.0;
      terminal = lib.mkDefault 0.9;
      desktop = 1.0;
      popups = 0.6;
    };

    image = ../wallpapers/desktop2.jpg;
  };
}
