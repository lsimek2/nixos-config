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

  ];

services.nextcloud = {                
  enable = true;                   
  [...]
  # Instead of using pkgs.nextcloud28Packages.apps,
  # we'll reference the package version specified above
  extraApps = {
    inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
  };
  hostName = "localhost";
  config.adminpassFile = "/etc/private/nextcloud-admin-pass";
  extraAppsEnable = true;
};

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = "pico";

  system.stateVersion = "24.05";

}
