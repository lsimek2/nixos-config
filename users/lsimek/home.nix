{
  config,
  pkgs,
  pkgs-unstable,
  modules,
  lib,
  ...
}:
let
  tex = (
    pkgs.texlive.combine {
      inherit (pkgs.texlive)
        scheme-medium
        textpos
        etextools
        environ
        fmtcount
        koma-script
        babel
        babel-croatian
        datetime
        geometry
        amsfonts
        csquotes
        tcolorbox
        pgf
        pgfplots
        arydshln
        float
        xcolor
        breqn
        thmtools
        multirow
        hyperref
        booktabs
        listings
        letltxmacro
        adjustbox
        enumitem
        biblatex
        placeins
        mathtools
        autonum
        url
        subfiles
        nowidow
        ;
    }
  );
in
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

  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "ls -l";
    };
  };

  programs.nushell.shellAliases = {
    latex-compile = "latexmk -pdf";
    latex-clear = "rm -f *.aux *.log *.out *.toc *.blg *.bbl *.synctex.gz *.fls *.fdb_latexmk *.bcf";
  };

  home.packages =
    (with pkgs-unstable; [
      nmap
      ani-cli
      protonup-ng
    ])
    ++ (with pkgs; [
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
      vesktop
      zathura

      tex
      biber
      texlab
      texmaker

      fuzzel

      (conda.override { extraPkgs = [ pkgs.which ]; })
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

  systemd.user.services.hyprpaper = {
    Unit = {
      After = [ "wayland-session-waitenv.service" ];
    };
  };

  systemd.user.services.hypridle = {
    Unit = {
      After = [ "wayland-session-waitenv.service" ];
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
    };
  };

  services.mako = {
    enable = true;
    anchor = "bottom-right";
    width = 350;
    margin = "0,20,20";
    borderSize = 1;
    borderRadius = 5;
    defaultTimeout = 10000;
    groupBy = "summary";
    icons = true;
  };

  programs.foot = {
    enable = true;
    server.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      source = "~/nixos/dotfiles/hypr/lsimek.conf";
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };
    };
    extraConfig = ''
      background {
          path = screenshot
          blur_passes = 2
          blur_size = 8
          }'';
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
        before_sleep_cmd = "loginctl lock-session "; # lock before suspend.
        after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
      };

      listener = [
        {
          timeout = 150; # 2.5min.
          on-timeout = "brightnessctl -s set 10"; # set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-resume = "brightnessctl -r "; # monitor backlight restore.
        }

        # turn off keyboard backlight, comment out this section if you dont have a keyboard backlight.
        {
          timeout = 150; # 2.5min.
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0 "; # turn off keyboard backlight.
          on-resume = "brightnessctl -rd rgb:kbd_backlight"; # turn on keyboard backlight.
        }

        {
          timeout = 300; # 5min
          on-timeout = "loginctl lock-session"; # lock screen when timeout has passed
        }

        {
          timeout = 330; # 5.5min
          on-timeout = "hyprctl dispatch dpms off "; # screen off when timeout has passed
          on-resume = "hyprctl dispatch dpms on"; # screen on when activity is detected after timeout has fired.
        }

        # {
        #   # timeout = 180; # 30min
        #   # on-timeout = "systemctl suspend"; # suspend pc
        # }
      ];
    };
  };

  stylix.targets.helix.enable = false;
  stylix.targets.foot.enable = true;
  stylix.targets.hyprpaper.enable = true;

  programs.helix = {
    enable = true;
    languages = {
      language-server.texlab.config.texlab = {
        build = {
          onSave = true;
        };
        forwardSearch = {
          executable = "zathura";

          args = [
            "--synctex-forward"
            "%l:1:%f"
            "%p"
          ];
        };
        chktex.onEdit = true;
      };
      language = [
        {
          name = "latex";
          auto-format = true;
          # config.texlab.build.onSave = true;

        }
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
        }
      ];
    };
    settings = {
      theme = lib.mkForce "tokyonight";
      editor.lsp = {
        display-inlay-hints = true;
      };
      editor.soft-wrap.enable = true;
    };
    themes = {
      autumn_night_transparent = {
        "inherits" = "autumn_night";
        "ui.background" = { };
      };
    };
  };

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
