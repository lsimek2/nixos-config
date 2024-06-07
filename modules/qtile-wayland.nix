{ pkgs, pkgs-stable, ... }:
{
  services.xserver.enable = true;
  services.xserver.windowManager.qtile = {
    enable = true;
    backend = "wayland";
  };
  
  environment.systemPackages = with pkgs; [
    wofi
    dunst
    caffeine-ng
    mypy
    pavucontrol
  ];

   nixpkgs.overlays = [
     (self: super: {
       qtile-unwrapped = pkgs-stable.qtile-unwrapped.overrideAttrs(_: rec {
         postInstall = let
           qtileSession = ''
           [Desktop Entry]
           Name=Qtile Wayland
           Comment=Qtile on Wayland
           Exec=qtile start -b wayland
           Type=Application
           '';
           in
           ''
         mkdir -p $out/share/wayland-sessions
         echo "${qtileSession}" > $out/share/wayland-sessions/qtile.desktop
         '';
         passthru.providedSessions = [ "qtile" ];
       });
     })
   ];

  services.displayManager.sessionPackages = [ pkgs.qtile-unwrapped ];

  services.xserver.xkb.variant = "us";
  services.xserver.xkb.layout = "hr";
}
  
