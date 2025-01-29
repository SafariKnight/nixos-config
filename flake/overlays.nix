{ inputs, ... }:
{
  flake.overlays = [
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
      umu-launcher = inputs.umu.packages.${final.system}.umu.override {
        version = inputs.umu.shortRev;
        truststore = true;
      };
    })
  ];
}
