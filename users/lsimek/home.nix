{ config, pkgs, modules, ... }:

{

  imports = [
    modules.nushell
    modules.nixvim
    modules.stylix-hm
    ../../dotfiles
  ];

  home.username = "lsimek";
  home.homeDirectory = "/home/lsimek";

  home.stateVersion = "23.11";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    #rstudio
    # (rstudioWrapper.override { packages = with rPackages; [ ggplot2 dplyr xts tidyverse ]; })

    dconf
    alacritty

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {

    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/carjin/etc/profile.d/hm-session-vars.sh
  #

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

  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  dconf.enable = true;
  programs.alacritty.enable = true;

  nixpkgs.config.allowUnfree = true;
}
