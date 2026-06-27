{
  pkgs-unstable,
  modules,
  pkgs,
  lib,
  ...
}:
{

  imports = [
    ./dotfiles.nix
    ./xdg-mime.nix
    ./yazi.nix
    ./mpv.nix
    ./jujutsu.nix
    # ./distrobox.nix
    ./pueue.nix
    ./foot.nix
    ./zathura.nix
    # ./conky.nix
    ./helix.nix
    ./git.nix
    ./zsh.nix
    ./udiskie.nix
    ./swaync.nix
    ./starship.nix
    ./rofi.nix
    ./kitty.nix
    ./fonts.nix
    ./latex.nix
    ./packages.nix
    # ./hyprland
    ./waybar
    ./nushell
    ./fuzzel.nix
    # ./firefox.nix
    ./emacs.nix
    ./niri
    ./typst.nix
    # ./stylix
    # ./theme
  ];

  home.username = "lsimek";
  home.homeDirectory = "/home/lsimek";

  home.stateVersion = "23.11";

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
        identityFile = "~/.ssh/id_ed25519";
        forwardAgent = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        compression = false;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
    };
  };

  services.ssh-agent = {
    enable = true;
  };

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

  home.sessionVariables = {
    EDITOR = "hx";
  };

  programs.home-manager.enable = true;

  dconf.enable = true;

  stylix = {
    icons = {
      enable = true;
      # package = lib.mkForce pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };
    targets = {
      helix.enable = true;
      waybar.enable = false;
      hyprland.enable = false;
      hyprlock.enable = false;
      vscode.enable = false;
      wofi.enable = false;
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    }; # fix ui virt-manager bug
  };

}
