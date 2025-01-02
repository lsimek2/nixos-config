{
  pkgs-unstable,
  modules,
  pkgs,
  ...
}:

{

  imports = [
    modules.nushell
    # modules.nixvim
    modules.stylix-hm
    ./dotfiles.nix
  ];

  home.username = "carjin";
  home.homeDirectory = "/home/carjin";

  home.stateVersion = "23.11";

  home.packages =
    (with pkgs-unstable; [
      tldr
      nmap
      ani-cli
      protonup-ng
    ])
    ++ (with pkgs; [
      calibre
      # logseq
      firefox
      inkscape
      librewolf
      chromium
      nextcloud-client
      oterm
      mpv
      peazip
      lutris
      deluge-gtk
      osu-lazer-bin
      dconf
      anki-bin
      gedit
      libreoffice
      vscode-fhs

      (rstudioWrapper.override {
        packages = with rPackages; [
          ggplot2
          dplyr
          xts
          tidyverse
        ];
      })
    ]);

  home.file = { };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      # splash = false;
      # splash_offset = 2.0;

      preload = [
        "Pictures/desktop.jpg"
      ];

      wallpaper = [
        "DP-1,Pictures/desktop.jpg"
        "DP-2,Pictures/desktop.jpg"
      ];
    };
  };

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
    userEmail = "karlo.puselj@gmail.com";
    userName = "Lunitur";
    extraConfig = {
      receive.denyCurrentBranch = "warn";
    };
  };

  dconf.enable = true;
  programs.alacritty.enable = true;

  nixpkgs.config.allowUnfree = true;

  programs.helix = {
    enable = true;
    languages = {
      language-server.metals.config.metals = {
        autoImportBuild = "all";
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
        }
        {
          name = "haskell";
          file-types = [
            "hs"
            "lhs"
          ];
          auto-format = true;
          formatter.command = "${pkgs.haskellPackages.ormolu}/bin/ormolu";
          # linter.command = "${pkgs.haskellPackages.hlint}/bin/hlint";
        }
        {
          name = "scala";
          auto-format = true;
          # formatter.command = "${pkgs.scalafmt}/bin/scalafmt";
        }
      ];
    };
    settings = {
      theme = "tokyonight";
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

  programs.foot = {
    enable = true;
    server.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      source = "~/nixos/dotfiles/hypr/carjin.conf";
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        # grace = 300;
        hide_cursor = true;
        # no_fade_in = false;
      };
    };
    extraConfig = ''
      background {
          path = screenshot
          blur_passes = 2
          blur_size = 8
          }'';
  };
  stylix.targets.helix.enable = false;
  stylix.targets.kde.enable = false;
  stylix.targets.foot.enable = true;
  stylix.targets.hyprpaper.enable = true;

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
