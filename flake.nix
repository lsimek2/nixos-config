{
  description = "Nixos config flake";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/master";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nuenv = {
      url = "https://flakehub.com/f/DeterminateSystems/nuenv/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    {
      self,
      nixpkgs-unstable,
      nixpkgs-stable,
      nixos-hardware,
      home-manager-stable,
      home-manager-unstable,
      stylix,
      nuenv,
      # nixos-cosmic,
      ...
    }@inputs:
    let
      pkgs-unstable = import nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
        overlays = [ nuenv.overlays.default ];
      };
      pkgs-stable = import nixpkgs-stable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      modules = import ./modules;
      user-pkgs = import ./pkgs { pkgs = pkgs-stable; };
      specialArgs = {
        inherit
          pkgs-unstable
          pkgs-stable
          modules
          user-pkgs
          stylix
          # nixos-cosmic
          ;
        home-manager = home-manager-unstable;
      };
    in
    {
      nixosConfigurations.victus = nixpkgs-stable.lib.nixosSystem {
        inherit specialArgs;
        system = "x86_64-linux";
        modules = [
          ./hosts/victus
          ./hosts # defaults
          ./users
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
          ./users
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
          ./users
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
