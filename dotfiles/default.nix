{ ... }: {
  home.file.".config/qtile".source = ./qtile;
  home.file.".config/xmonad".source = ./xmonad;
  home.file.".config/xmobar".source = ./xmobar;
  home.file.".config/picom".source = ./picom;
  home.file.".config/nushell/startup.nu".source = ./nushell/startup.nu;
  home.file.".config/nushell/completers.nu".source = ./nushell/completers.nu;
  home.file.".config/kmonad".source = ./kmonad;
  home.file.".config/dunst".source = ./dunst;
  home.file.".config/sway".source = ./sway;
  home.file.".config/waybar".source = ./waybar;
}
