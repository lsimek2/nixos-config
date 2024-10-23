{ config, lib, pkgs, inputs, modules, ... }:
let
  monitor = import ./monitor.nix { inherit pkgs; };
in
{
  imports =
    [
      ./hardware-configuration.nix
      modules.sway
    ];
    
  environment.systemPackages = with pkgs; [
    moonlight-qt
  ];

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };

  programs.virt-manager.enable = true;


  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.waydroid.enable = true;

  users.extraGroups.vboxusers.members = [ "carjin" ];

  services.xserver.videoDrivers = [ "intel" ];

  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    settings = {
      Autologin = {
        Session = "sway.desktop";
        User = "carjin";
      };
    };
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


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [ "fbcon=rotate:1" ];
  boot.loader.systemd-boot.consoleMode = "0";

  networking.hostName = "minibook";

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; }; # Force intel-media-driver

  system.stateVersion = "24.05";

}

