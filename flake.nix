{
  description = "My NixOS config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Cosmic
    # nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    # nixpkgs.follows = "nixos-cosmic/nixpkgs";

    # Have both in case I want to switch the original, so whatever is explicitly specified doesn't change
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";
    ags.url = "github:Aylur/ags";
    ags.inputs.nixpkgs.follows = "nixpkgs";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # lix-module = {
    #   url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # poggers
    ghostty = {
      url = "git+ssh://git@github.com/ghostty-org/ghostty";
      # I have to do this for whatever reason
      inputs.nixpkgs-unstable.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };

    minimal-tmux = {
      # why do I really like this statusbar
      url = "github:niksingh710/minimal-tmux-status";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    # home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    mkSystem = import ./lib/mksystem.nix {inherit nixpkgs inputs outputs;};

    supportedSystems = [
      "x86_64-linux" # 64-bit Intel/AMD Linux
      "aarch64-linux" # 64-bit ARM Linux
      "x86_64-darwin" # 64-bit Intel macOS
      "aarch64-darwin" # 64-bit ARM macOS
    ];
    forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {pkgs = import nixpkgs {inherit system;};});
  in
    (mkSystem "krypton" {
      system = "x86_64-linux";
      user = "kareem";
    })
    // {
      nixConfig = {
        warn-dirty = false;
      };

      overlays = import ./overlays {inherit inputs;};
      formatter = forEachSupportedSystem ({pkgs}: pkgs.alejandra);
      devShells = forEachSupportedSystem (
        {pkgs}: {
          default = pkgs.mkShell {
            packages = with pkgs; [
              lua
              luajit
              lua-language-server
              stylua
              nixd
              alejandra
            ];
          };
        }
      );
    };
}
