{
  description = "My NixOS config";
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      imports = [
        ./flake
        ./machines
        inputs.treefmt-nix.flakeModule
      ];
    };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    systems.url = "github:nix-systems/default-linux";

    treefmt-nix.url = "github:numtide/treefmt-nix";

    # Have both in case I want to switch the original, so whatever is explicitly specified doesn't change
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland/v0.47.2";

    # hyprtasking = {
    #   url = "github:raybbian/hyprtasking";
    #   inputs.hyprland.follows = "hyprland";
    # };

    nur.url = "github:nix-community/NUR";

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    minimal-tmux = {
      url = "github:niksingh710/minimal-tmux-status";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    umu = {
      # why isn't this packaged
      url = "github:Open-Wine-Components/umu-launcher?dir=packaging/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
