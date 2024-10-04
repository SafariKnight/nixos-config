{
  inputs,
  outputs,
  nixpkgs,
  ...
}: machine: {
  system,
  user,
}:
nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = {
    inherit inputs;
    inherit outputs;
  };
  modules = [
    ./../machines/${machine}
    ./../machines/${machine}/hardware.nix
    {
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
    }
    inputs.stylix.nixosModules.stylix
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
      };
    }
    {system.stateVersion = "24.05";}
    inputs.home-manager.nixosModules.home-manager
    inputs.lix-module.nixosModules.default
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user} = import ./../users/${user}.nix;
      home-manager.extraSpecialArgs = {
        inherit inputs outputs;
      };
      home-manager.backupFileExtension = "home-backup";
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
}
