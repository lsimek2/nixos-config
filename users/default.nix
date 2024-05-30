{inputs, modules,...}:
{
  imports = [
    ./carjin/user.nix
    ./lsimek/user.nix
  ];

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = { inherit inputs; inherit modules; };
    users = {
      carjin = import ./carjin/home.nix;
      lsimek = import ./lsimek/home.nix;
    };

    backupFileExtension = "backup";
  };
}
