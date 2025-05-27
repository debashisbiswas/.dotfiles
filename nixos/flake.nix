{
  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-emacsmacport = {
      url = "github:railwaycat/homebrew-emacsmacport";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, hardware, nix-darwin, ... }@inputs:
    let
      inherit (self) outputs;
    in
    {
      nixosConfigurations = {

        mipha = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/mipha ];
          specialArgs = { inherit inputs outputs; };
        };

        lumine = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/lumine ];
          specialArgs = { inherit inputs outputs; };
        };

      };

      darwinConfigurations = {
        vale = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [ ./hosts/vale ];
          specialArgs = { inherit inputs; };
        };
      };
    };
}
