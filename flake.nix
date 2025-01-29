{
  description = "Nixos config flake";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/master";

    umu.url = "github:Open-Wine-Components/umu-launcher?dir=packaging/nix";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager-stable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

  };

  outputs =
    {
      self,
      nixpkgs-unstable,
      nixpkgs-stable,
      nixos-hardware,
      home-manager-stable,
      stylix,
      ...
    }@inputs:
    let
      pkgs-unstable = import nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
        overlays = [ ];
      };
      pkgs-unstable-arm = import nixpkgs-unstable {
        system = "aarch64-linux";
        config.allowUnfree = true;
        overlays = [ ];
      };
      modules = import ./modules;
      specialArgs = {
        inherit
          pkgs-unstable
          pkgs-unstable-arm
          modules
          stylix
          inputs
          ;
      };
    in
    {
      nixosConfigurations.victus = nixpkgs-stable.lib.nixosSystem {
        inherit specialArgs;
        system = "x86_64-linux";
        modules = [
          ./hosts/victus
          ./hosts # defaults
          ./network
          home-manager-stable.nixosModules.default
          stylix.nixosModules.stylix
          modules.stylix
          #          modules.cosmic
        ];
      };
      nixosConfigurations.centaur = nixpkgs-stable.lib.nixosSystem {
        inherit specialArgs;
        system = "x86_64-linux";
        modules = [
          ./hosts/centaur
          ./hosts # defaults
          ./network
          home-manager-stable.nixosModules.default
          stylix.nixosModules.stylix
          modules.stylix
          #          modules.cosmic
        ];
      };
      nixosConfigurations.minibook = nixpkgs-stable.lib.nixosSystem {
        inherit specialArgs;
        system = "x86_64-linux";
        modules = [
          ./hosts/minibook
          ./hosts # defaults
          ./network
          nixos-hardware.nixosModules.chuwi-minibook-x
          home-manager-stable.nixosModules.default
          stylix.nixosModules.stylix
          modules.stylix
        ];
      };
      nixosConfigurations.pico = nixpkgs-stable.lib.nixosSystem {
        inherit specialArgs;
        system = "aarch64-linux";
        modules = [
          ./hosts/pico
          ./hosts # defaults
          ./users/carjin/user.nix
          ./network
        ];
      };
    };
}
