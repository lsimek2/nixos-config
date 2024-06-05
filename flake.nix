{
  description = "Nixos config flake";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/master";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };

  outputs = { self, nixpkgs-unstable, nixpkgs-stable, home-manager-stable, home-manager-unstable, nixvim, ... }@inputs:
    let
      pkgs-unstable = import nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      pkgs-stable = import nixpkgs-stable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      modules = import ./modules;
      user-pkgs = import ./pkgs { pkgs = pkgs-stable; };
    in
    {
      nixosConfigurations.victus = nixpkgs-stable.lib.nixosSystem {
        specialArgs = {
          inherit pkgs-unstable pkgs-stable modules user-pkgs nixvim;
          home-manager = home-manager-stable;
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/victus
          ./hosts #defaults
          ./users
          home-manager-stable.nixosModules.default
        ];
      };
      nixosConfigurations.centaur = nixpkgs-stable.lib.nixosSystem {
        specialArgs = {
          inherit pkgs-unstable pkgs-stable modules user-pkgs nixvim;
          home-manager = home-manager-stable;
        };
        system = "x86_64-linux";
        modules = [
          ./hosts/centaur
          ./hosts #defaults
          ./users
          home-manager-stable.nixosModules.default
        ];
      };
    };
}
