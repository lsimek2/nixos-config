{ config, lib, pkgs, inputs, ... }:

{

  imports = [
    ../users/users.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.tmp.cleanOnBoot = true;
    
  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users = {
      carjin = import ../users/carjin/home.nix;
      lsimek = import ../users/lsimek/home.nix;
    };

   backupFileExtension = "backup";
  };
  
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
 
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
};

  services.libinput.enable = true;

  environment.systemPackages = with pkgs; [
    git
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    nano
    nushell
    gvfs
    pueue
    fastfetch
    unar
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
