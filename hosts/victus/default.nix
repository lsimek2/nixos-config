# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, modules, ... }:
let multimonitor = import ./multimonitor.nix { inherit pkgs; };
in {
  imports =
    [ ./hardware-configuration.nix modules.qtile ./nvidia.nix modules.nix-ld ];

  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
  };

  powerManagement = {
    enable = true;
    # powertop.enable = true;
  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  services.redshift = {
    enable = true;
    brightness = {
      # Note the string values below.
      day = "1";
      night = "1";
    };
    temperature = {
      day = 5500;
      night = 3700;
    };
  };

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images


  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.enable = true;
  #services.displayManager.sddm.enable = true;

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      efiSupport = true;
      useOSProber = true;
      device = "nodev";
    };
  };

  boot.crashDump.enable = true;

  nixpkgs.config.allowUnfree = true;

  services.xserver.displayManager.setupCommands =
    "${multimonitor}/bin/multimonitor";

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  networking.hostName = "victus"; # Define your hostname.

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    xfce.thunar
    multimonitor
    kmonad
    networkmanagerapplet
    xmobar
    xcompmgr
    rofi
    stalonetray
    #  blueman

    (
      let
        my-python-packages = python-packages:
          with python-packages; [
            matplotlib
            numpy
            pandas
            scikit-learn
          ];
        python-with-my-packages = python3.withPackages my-python-packages;
      in
      python-with-my-packages
    )
  ];

  system.stateVersion = "23.11";

}

