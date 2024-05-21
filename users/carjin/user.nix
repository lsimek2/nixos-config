{ config, lib, pkgs, inputs, ...}:
{
  imports = [
#    ./home.nix
  ];

  users.users.carjin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "input" ]; # input uinput for kmonad
    openssh.authorizedKeys.keys =
      [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDhjgro/JnCCqYuHT/eiTv0EYqW8kN/MYL/nBmOJ+5l9 karlo.puselj@gmail.com" ];
    packages = with pkgs; [
      firefox
      tree
      discord
      steam
      lutris
      unrar
      unar
    ];
  };

}
