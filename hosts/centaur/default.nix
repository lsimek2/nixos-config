# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  modules,
  pkgs-unstable,
  inputs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/jupyter.nix
    # ../../users/carjin/user.nix
    ../../users/lsimek/user.nix
    ./kmonad.nix
  ];

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {
      inherit modules pkgs-unstable inputs;
    };
    users = {
      # carjin = import ../../users/carjin/home.nix;
      lsimek = import ../../users/lsimek/home.nix;
    };

    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  services.xserver.enable = true;
  services.sunshine.enable = true;
  services.sunshine.openFirewall = true;

  programs.gamescope = {
    enable = true;
    capSysNice = true; # Essential for high-priority scheduling (smooth frame pacing)
  };

  # ┃               permittedInsecurePackages = [
  # ┃                 "electron-36.9.5"
  # ┃               ];┃

  programs.niri.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    settings = {
      Autologin = {
        Session = "niri.desktop";
        User = "lsimek";
      };
    };
  };

  services._3proxy = {
    enable = true;
    services = [
      {
        type = "socks";
        auth = [ "strong" ];
        acl = [
          {
            rule = "allow";
            users = [ "master" ];
          }
        ];
      }
    ];
    usersFile = "/etc/3proxy.passwd";
  };

  environment.etc = {
    "3proxy.passwd".text = ''
      master:CR:$1$czCls9cH$.zIWiB42e4huFnrGAbwos.
    '';
  };

  networking.firewall.allowedUDPPorts = [ 1080 ];
  networking.firewall.allowedTCPPorts = [ 1080 ];

  services.ollama = {
    enable = true;
    openFirewall = true;
    package = pkgs-unstable.ollama-cuda;
    host = "0.0.0.0";
    loadModels = [
      "qwen3-coder-next"
      "qwen3.5:27b"
    ];
  };

  boot.supportedFilesystems = [ "ntfs" ];

  # services.open-webui = {
  #   enable = true;
  #   openFirewall = true;
  #   host = "centaur.akita-bleak.ts.net";
  #   environment = {
  #     WEBUI_AUTH = "True";
  #     ENABLE_SIGNUP = "True";
  #   };
  # };

  nix.settings.experimental-features = [ "nix-command" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader = {
  #  efi = {
  #    canTouchEfiVariables = true;
  #    efiSysMountPoint = "/boot/efi";
  #  };
  #  grub = {
  #      efiSupport = true;
  #      device = "nodev";
  #  };
  #};

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

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
    package = config.boot.kernelPackages.nvidiaPackages.beta;

  };

  # Unfree software
  nixpkgs.config.allowUnfree = true;

  users.defaultUserShell = pkgs.nushell;
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono # bilo bi bolje da su samo iskljcuvo oni koji se koriste
  ];

  networking.hostName = "centaur"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  services.libinput.enable = true;

  users.users.lsimek = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      tree
      git
      fish
      feh
    ];
  };

  environment.systemPackages = with pkgs; [
    nushell
    thunar
    picom
    nerd-fonts.jetbrains-mono
    pueue
    jetbrains.pycharm-oss
    # ollama-cuda
    # logseq
    kdePackages.ghostwriter

    (pkgs.writeShellScriptBin "claude-deepseek" ''
      export ANTHROPIC_BASE_URL="https://api.deepseek.com/anthropic"
      export ANTHROPIC_MODEL="deepseek-v4-flash"
      export ANTHROPIC_DEFAULT_OPUS_MODEL="deepseek-v4-pro[1m]"
      export ANTHROPIC_DEFAULT_SONNET_MODEL="deepseek-v4-pro[1m]"
      export ANTHROPIC_DEFAULT_HAIKU_MODEL="deepseek-v4-flash"
      export CLAUDE_CODE_SUBAGENT_MODEL="deepseek-v4-flash"
      export CLAUDE_CODE_EFFORT_LEVEL="max"
      export ANTHROPIC_AUTH_TOKEN=$(cat ~/Nextcloud/deepseek.key)
      unset CLAUDE_CODE_OAUTH_TOKEN

      exec ${pkgs.claude-code}/bin/claude "$@"
    '')
    (pkgs.writeShellScriptBin "claude-anthropic" ''
      unset ANTHROPIC_AUTH_TOKEN
      unset ANTHROPIC_BASE_URL
      unset ANTHROPIC_MODEL
      unset ANTHROPIC_DEFAULT_OPUS_MODEL
      unset ANTHROPIC_DEFAULT_SONNET_MODEL
      unset ANTHROPIC_DEFAULT_HAIKU_MODEL
      unset CLAUDE_CODE_SUBAGENT_MODEL
      unset CLAUDE_CODE_EFFORT_LEVEL

      exec ${pkgs.claude-code}/bin/claude "$@"
    '')

  ];

  environment.variables = {
    ANTHROPIC_BASE_URL = "https://api.deepseek.com/anthropic";
    ANTHROPIC_MODEL = "deepseek-v4-flash";
    ANTHROPIC_DEFAULT_OPUS_MODEL = "deepseek-v4-pro[1m]";
    ANTHROPIC_DEFAULT_SONNET_MODEL = "deepseek-v4-pro[1m]";
    ANTHROPIC_DEFAULT_HAIKU_MODEL = "deepseek-v4-flash";
    CLAUDE_CODE_SUBAGENT_MODEL = "deepseek-v4-flash";
    CLAUDE_CODE_EFFORT_LEVEL = "max";
  };

  environment.sessionVariables = {
    ANTHROPIC_BASE_URL = "https://api.deepseek.com/anthropic";
    ANTHROPIC_MODEL = "deepseek-v4-flash";
    ANTHROPIC_DEFAULT_OPUS_MODEL = "deepseek-v4-pro[1m]";
    ANTHROPIC_DEFAULT_SONNET_MODEL = "deepseek-v4-pro[1m]";
    ANTHROPIC_DEFAULT_HAIKU_MODEL = "deepseek-v4-flash";
    CLAUDE_CODE_SUBAGENT_MODEL = "deepseek-v4-flash";
    CLAUDE_CODE_EFFORT_LEVEL = "max";
  };

  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;
  hardware.bluetooth.enable = true;

  networking.firewall.enable = false;

  system.stateVersion = "23.11";

}
