{
  inputs,
  outputs,
  nixpkgs,
  ...
}:
machine:
{ system, user }:
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
          outputs.overlays.stable-packages
          inputs.nur.overlay
        ];
        config = {
          allowUnfree = true;
        };
      };
    }
    {
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
    }
    { system.stateVersion = "24.05"; }
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user} = import ./../users/${user}.nix;
      home-manager.extraSpecialArgs = {
        inherit inputs outputs;
      };
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
