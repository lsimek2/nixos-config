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
    package = pkgs.nextcloud30;
    # Instead of using pkgs.nextcloud28Packages.apps,
    # we'll reference the package version specified above
    hostName = "localhost";
    https = true;
    config = {
      adminpassFile = "/etc/private/nextcloud-admin-pass";
      adminuser = "root";
    };
    # settings.trusted_domains = [ "pico" ];
    settings = let
      prot = "https"; # or https
      host = "pico.akita-bleak.ts.net";
      dir = "/";
    in {
      overwriteprotocol = prot;
      overwritehost = host;
      overwritewebroot = dir;
      overwrite.cli.url = "${prot}://${host}${dir}/";
      htaccess.RewriteBase = dir;
      trusted_domains = [ "pico" "pico.akita-bleak.ts.net" "localhost" ];
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = "pico";
  networking.firewall = {
    allowedUDPPorts = [
      80
      443
    ];
    allowedTCPPorts = [
      80
      443
    ];
  };

  system.stateVersion = "24.05";

}
