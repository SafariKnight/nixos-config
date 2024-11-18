{
  inputs,
  outputs,
  nixpkgs,
  ...
}: machine: {
  system,
  user,
}: let
  home = {
    extraSpecialArgs = {
      inherit inputs outputs;
    };
  };
  nixpkgs-settings = {
    nixpkgs = {
      overlays = [
        outputs.overlays.extra-packages
        outputs.overlays.additions
        inputs.nur.overlay
      ];
      config = {
        allowUnfree = true;
      };
    };
  };
in {
  nixosConfigurations.${machine} = nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs;
      inherit outputs;
    };
    modules = [
      ./../machines/${machine}
      ./../machines/${machine}/hardware.nix
      nixpkgs-settings
      ../theme/nord.nix
      {
        nix = {
          extraOptions = "warn-dirty = false";
          gc.automatic = false;
          optimise.automatic = true;
          optimise.dates = ["weekly"];

          settings.cores = 8;
          settings.max-jobs = 16;
          settings.use-xdg-base-directories = true;
          settings.experimental-features = [
            "nix-command"
            "flakes"
          ];
          settings.substituters = [
            # "https://cosmic.cachix.org/"
            "https://ghostty.cachix.org/"
          ];
          settings.trusted-public-keys = [
            # "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
            "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
          ];
        };
      }
      {system.stateVersion = "24.05";}
      inputs.stylix.nixosModules.stylix
      inputs.home-manager.nixosModules.home-manager
      # inputs.lix-module.nixosModules.default
      # inputs.nixos-cosmic.nixosModules.default
      {
        home-manager = (
          home
          // {
            users.${user} = import ./../users/${user}.nix;
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "BACKUP.HOME";
          }
        );
      }
      {
        # Extra arguments I can import into any modules
        config._module.args = {
          systemType = system;
          machineName = machine;
          userName = user;
          inputs = inputs;
          outputs = outputs;
        };
      }
    ];
  };
  homeConfigurations.${user} = inputs.home-manager.lib.homeManagerConfiguration (
    home
    // {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [
        (import ./../users/${user}.nix)
        inputs.stylix.homeManagerModules.stylix
        ../theme/nord.nix
        nixpkgs-settings
        # inputs.lix-module.nixosModules.default
      ];
    }
  );
}
