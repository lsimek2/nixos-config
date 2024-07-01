{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.xmobar
  ];

  services.xserver = {
    enable = true;
    xkb.variant = "us";
    xkb.layout = "hr";

    #     displayManager = {
    #       lightdm.enable = true;
    #       sessionCommands = ''
    #         xset -dpms  # Disable Energy Star, as we are going to suspend anyway and it may hide "success" on that
    #         xset s blank # `noblank` may be useful for debugging 
    #         xset s 300 # seconds
    #         ${pkgs.lightlocker}/bin/light-locker --idle-hint &
    #       '';
    #     };
    # 
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      # config = builtins.readFile ../dotfiles/xmonad/xmonad.hs;
    };

  };
}
