{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.victus = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; modules = import ./modules; };
      system = "x86_64-linux";
      modules = [
        ./hosts/victus
        ./hosts #defaults
        ./users
        inputs.home-manager.nixosModules.default
      ];
    };
    nixosConfigurations.centaur = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./hosts/centaur/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
    nixosConfigurations.minibook = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./hosts/minibook/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
    nixosConfigurations.freebook = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./hosts/freebook/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
