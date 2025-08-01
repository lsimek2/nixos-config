{
  description = "Nixos config flake";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/master";

    umu.url = "github:Open-Wine-Components/umu-launcher?dir=packaging/nix";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    # nixpkgs-stable.follows = "nixos-cosmic/nixpkgs-stable"; # NOTE: change "nixpkgs" to "nixpkgs-stable" to use stable NixOS release

    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # nixos-hardware.url = "path:/home/carjin/nixos-hardware";

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    stylix = {
      url = "github:danth/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    simple-nixos-mailserver.url = "gitlab:simple-nixos-mailserver/nixos-mailserver/nixos-25.05";
  };

  outputs =
    {
      self,
      nixpkgs-unstable,
      nixpkgs-stable,
      nixos-hardware,
      home-manager-stable,
      simple-nixos-mailserver,
      stylix,
      nixos-cosmic,
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
      nixosConfigurations.freebook = nixpkgs-stable.lib.nixosSystem {
        inherit specialArgs;
        system = "x86_64-linux";
        modules = [
          ./hosts/freebook
          ./hosts # defaults
          ./network
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-pc-laptop
          nixos-hardware.nixosModules.common-pc-laptop-ssd
          nixos-hardware.nixosModules.common-hidpi
          home-manager-stable.nixosModules.default
          stylix.nixosModules.stylix
          modules.stylix
        ];
      };
      nixosConfigurations.corebook = nixpkgs-stable.lib.nixosSystem {
        inherit specialArgs;
        system = "x86_64-linux";
        modules = [
          ./hosts/corebook
          ./hosts # defaults
          ./network
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-pc-laptop
          nixos-hardware.nixosModules.common-pc-laptop-ssd
          nixos-hardware.nixosModules.common-hidpi
          home-manager-stable.nixosModules.default
          stylix.nixosModules.stylix
          modules.stylix
          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
          }
          # nixos-cosmic.nixosModules.default
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
          simple-nixos-mailserver.nixosModule
        ];
      };
    };
}
