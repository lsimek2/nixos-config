{
  config,
  lib,
  pkgs,
  inputs,
  modules,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    helix
  ];

  services.nextcloud = {                
    enable = true;                   
    # Instead of using pkgs.nextcloud28Packages.apps,
    # we'll reference the package version specified above
    hostName = "localhost";
    config = {
     adminpassFile = "/etc/private/nextcloud-admin-pass";
     adminuser = "root"; };
    settings.trusted_domains = [ "pico" ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = "pico";

  system.stateVersion = "24.05";

}
