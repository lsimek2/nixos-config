# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:
let
  multimonitor = import ./multimonitor.nix { inherit pkgs; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../default.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
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

  services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.displayManager.lightdm.extraConfig = ''display-setup-script = ${multimonitor}/bin/multimonitor'';
  services.xserver.displayManager.setupCommands = "${multimonitor}/bin/multimonitor";

# Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    forceFullCompositionPipeline = true;

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  
    prime = {
#     offload = {
#       enable = true;
#       enableOffloadCmd = true;
#     };
      sync.enable = true;
      # Make sure to use the correct Bus ID values for your system!
      amdgpuBusId = "PCI:7:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  networking.hostName = "victus"; # Define your hostname.


  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

    # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    nano
    nushell
    alacritty
    xfce.thunar
    gvfs
    mypy # Qtile dependency
  #  python311Packages.numpy
    fish
    picom
    nerdfonts
    pueue
    gedit
    multimonitor
    signal-desktop
    element-desktop
    rofi
    nextcloud-client
    kmonad
  #  python311
  #  qtile-unwrapped
    networkmanagerapplet

    (let
      my-python-packages = python-packages: with python-packages; [
        matplotlib
        numpy
        pandas
        scikit-learn
      ];
     python-with-my-packages = python3.withPackages my-python-packages;
     in
    python-with-my-packages)
  ];
  #services.xserver.windowManager.session = [{
  #  name = "qtile";
  #  start = ''
  #    /usr/bin/env qtile start -b x11 &
  #    waitPID=$!
  #  '';
  #}];
}

