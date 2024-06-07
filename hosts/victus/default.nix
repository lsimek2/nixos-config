# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, modules, ... }:
let
  multimonitor = import ./multimonitor.nix { inherit pkgs; };
in
{
  imports =
    [
      ./hardware-configuration.nix
      modules.qtile
      ./nvidia.nix
    ];

  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
  };

  
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
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
      device = "nodev";
    };
  };

  nixpkgs.config.allowUnfree = true;

  services.xserver.displayManager.setupCommands = "${multimonitor}/bin/multimonitor";

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
        my-python-packages = python-packages: with python-packages; [
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

