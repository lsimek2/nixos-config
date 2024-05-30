{ pkgs, ... }:
{

  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    # Whether to enable XWayland
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    caffeine-ng
    pavucontrol
    wl-clipboard
    wf-recorder
    rofi
    wlogout
    swaylock-effects
    dunst
    swaybg
    kitty
    grimblast
    hyprpicker
    nwg-look
    qt5ct
    btop
    jq
    gvfs
    ffmpegthumbs
    swww
    xfce.mousepad
    mpv
    playerctl
    pamixer
    ffmpeg
    neovim
    viewnior
    pavucontrol
    xfce.thunar
    ffmpegthumbnailer
    xfce.tumbler
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    waybar
    nordic
    papirus-icon-theme
    starship
  ];

}
  
