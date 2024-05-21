{ config, lib, pkgs, inputs, ...}:
{
  imports = [
#    ./home.nix
  ];

  users.users.lsimek = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "input" ]; # input uinput for kmonad
    openssh.authorizedKeys.keys =
      [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAa4p4eaMH3uBaxjn+yQuD7TzvDzE/5gP3/Xshn1S0vj tinjano@proton.me" ];
    packages = with pkgs; [
	firefox	
	thunderbird
	# conda
	# nvim
	tree
	steam
    ];
  };

}
