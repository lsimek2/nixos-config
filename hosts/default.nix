{ config, lib, pkgs, user-pkgs, pkgs-unstable, pkgs-stable, ... }:

{

  imports = [ ];

  # zramSwap.enable = true;

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
        "https://victus.cachix.org/"
        "http://victus.akita-bleak.ts.net/"
      ];
      trusted-public-keys = [
        "victus.akita-bleak.ts.net:kb/jFWfxfUVJfWlLeu+qEYO3zGkNHdfCvb61qSHRo3A="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "victus.cachix.org-1:VQvwDrGr4O3e1G64Xl97fl2QdHRxr3LieTYldF84jIY="
      ];
    };
  };

  security.polkit.enable = true;

  boot.tmp.cleanOnBoot = true;

  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs;
    [
      nerdfonts # bilo bi bolje da su samo iskljcuvo oni koji se koriste
    ];

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Zagreb";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  location = {
    latitude = 45.8;
    longitude = 16.0;
  };

  services.libinput.enable = true;

  environment.systemPackages = (with pkgs; [
    git
    wget
    nano
    nushell
    gvfs
    pueue
    fastfetch
    unar
    nixpkgs-fmt
    rustc
    cargo
    nh
    bash

    ghc
    (haskell-language-server.override { supportedGhcVersions = [ "96" "910" ]; })
    stack

    alsa-utils
    brightnessctl

    virtiofsd # libvirt folder sharing

    scala
    metals

    telegram-desktop
    vesktop

    julia

    rust-analyzer
    lldb_18 # rust lsp

    gcc # rust linker error

    wlsunset
  ]) ++ (with user-pkgs; [ repl wl-ocr ]) ++ [
    #   (pkgs-unstable.nuenv.writeScriptBin {
    #     name = "run-me";
    #     script = ''
    #       def blue [msg: string] { $"(ansi blue)($msg)(ansi reset)" }
    #       blue "Hello world"
    #     '';
    #   })
  ];

  programs.direnv.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.allowedUDPPorts = [ 22 ];

  #kmonad
  boot.kernelModules = [ "uinput" ];

  services.udev.extraRules = ''
    KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", OPTIONS+="static_node=uinput", GROUP="input", MODE="0660"
  '';

  services.mullvad-vpn.enable = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  services.btrfs.autoScrub.enable = true;

  users.defaultUserShell = pkgs.nushell;

}
