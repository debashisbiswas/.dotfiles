{
  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixos-hardware }: {
    nixosConfigurations.mipha = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix

        # https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
        nixos-hardware.nixosModules.lenovo-thinkpad-t480
      ];
    };
  };
}
