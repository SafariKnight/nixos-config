{
  inputs,
  self,
  ...
}: {
  # overlays = import ./overlays {inherit inputs;};
  perSystem = {
    pkgs,
    # inputs',
    system,
    ...
  }: {
    formatter = pkgs.alejandra;
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [
        (final: _prev: import ../pkgs final.pkgs)
        (final: _prev: {
          stable = import inputs.nixpkgs-stable {
            system = final.system;
            config.allowUnfree = true;
          };
          unstable = import inputs.nixpkgs-unstable {
            system = final.system;
            config.allowUnfree = true;
          };
        })
      ];
      config = {};
    };
  };
  imports = [
    ./devShell.nix
    # ./overlays.nix
  ];
}
