{
  config,
  pkgs,
  pkgs-stable,
  pkgs-unstable,
  modules,
  ...
}:

{

  imports = [
    modules.nushell
    # modules.nixvim
    modules.stylix-hm
    ./dotfiles.nix
  ];

  home.username = "lsimek";
  home.homeDirectory = "/home/lsimek";

  home.stateVersion = "23.11";

  home.packages =
    (with pkgs-unstable; [
      nmap
      ani-cli
      protonup-ng
    ])
    ++ (with pkgs-stable; [
      calibre
      firefox
      librewolf
      chromium
      thunderbird
      peazip
      lutris
      deluge-gtk
      nextcloud-client
      mpv
      texlab
      dconf
      gedit
      libreoffice
    ]);

  home.file = { };

  home.sessionVariables = {
    EDITOR = "hx";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  services.pueue = {
    enable = true;
    settings = {
      daemon = {
        default_parallel_tasks = 64;
      };
    };
  };

  programs.git = {
    enable = true;
    userEmail = "tinjano@proton.me";
    userName = "lsimek";
  };

  dconf.enable = true;
  programs.alacritty.enable = true;

  nixpkgs.config.allowUnfree = true;

  programs.helix = {
    enable = true;
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
      }
    ];
    settings = {
      theme = "tokyodark";
      editor.lsp = {
        display-inlay-hints = true;
      };
    };
    themes = {
      autumn_night_transparent = {
        "inherits" = "autumn_night";
        "ui.background" = { };
      };
    };
  };

  stylix.targets.helix.enable = false;
  stylix.targets.kde.enable = false;

  gtk.iconTheme = {
    package = pkgs.papirus-icon-theme;
    name = "Papirus";
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    }; # fix ui virt-manager bug
  };

}
