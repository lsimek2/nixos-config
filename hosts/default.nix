{ config, lib, pkgs, inputs, ... }:

{

  imports = [
    ../users/users.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
    
  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users = {
      carjin = import ../users/carjin/home.nix;
      lsimek = import ../users/lsimek/home.nix;
    };

   backupFileExtension = "backup";
  };
 
  users.defaultUserShell = pkgs.nushell;
 
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    nerdfonts #bilo bi bolje da su samo iskljcuvo oni koji se koriste
  ];

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Zagreb";

  services.xserver.enable = true;

  services.xserver.windowManager.qtile.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
 
  services.libinput.enable = true;

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    nano
    nushell
    alacritty
    xfce.thunar
    gvfs
    fish
    picom
    nerdfonts
    pueue
    gedit
    rofi
    nextcloud-client
    kmonad
    networkmanagerapplet
    fastfetch
  ];
  
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.allowedUDPPorts = [ 22 ];

  system.stateVersion = "23.11";

  #kmonad
  boot.kernelModules = [ "uinput" ];

  services.udev.extraRules = ''
    KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", OPTIONS+="static_node=uinput", GROUP="input", MODE="0660"
  '';
}
