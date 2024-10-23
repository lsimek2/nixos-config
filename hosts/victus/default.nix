{ config, lib, pkgs, inputs, modules, pkgs-stable, ... }:
let
  multimonitor = import ./multimonitor.nix { inherit pkgs; };
  upkgs = with pkgs; [
    multimonitor
    virtiofsd # libvirt folder sharing
    looking-glass-client
  ];
  spkgs = with pkgs-stable; [];
in
{
  imports = [
    ./hardware-configuration.nix
    modules.nix-ld
    modules.sway
    ./vfio.nix
    ./kvmfr.nix
  ];

  services.nix-serve = {
    enable = true;
    secretKeyFile = "/etc/private/cache-priv-key.pem";
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "victus.akita-bleak.ts.net" = {
        locations."/".proxyPass =
          "http://${config.services.nix-serve.bindAddress}:${
            toString config.services.nix-serve.port
          }";
      };
    };
  };

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  # services.desktopManager.plasma6.enable = true;

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

  vfio.enable = true;

  specialisation.no-vfio.configuration = { vfio.enable = lib.mkForce false; };

  boot.supportedFilesystems = [ "ntfs" ];

  programs.sway.extraOptions = [ "--unsupported-gpu" ];

  powerManagement = {
    enable = true;
    # powertop.enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall =
      true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall =
      true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall =
      true; # Open ports in the firewall for Steam Local Network Game Transfers
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
  
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

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

  boot.kernelPackages = pkgs.linuxPackages_xanmod;
  boot.kernelParams = [ "amd_iommu=on" ]; # "amd_pstate=disable"

  # Enable kernel debug mode
  # boot.crashDump.enable = true;

  services.xserver.displayManager.setupCommands =
    "${multimonitor}/bin/multimonitor";

  networking.hostName = "victus"; # Define your hostname.

  environment.systemPackages = upkgs ++ spkgs;

  system.stateVersion = "23.11";

}

