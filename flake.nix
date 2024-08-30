{
  description = "My NixOS config";
  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      nur.url = "github:nix-community/NUR";
      nixvim = {
        url = "github:nix-community/nixvim";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      mkSystem = import ./lib/mksystem.nix { inherit nixpkgs inputs outputs; };
    in
    {
      overlays = import ./overlays { inherit inputs; };
      nixosConfigurations = {
        desktop = mkSystem "desktop" {
          system = "x86_64_linux";
          user = "kareem";
        };
      };
    };
}