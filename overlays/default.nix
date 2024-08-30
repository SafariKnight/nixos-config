{ inputs, ... }:
{
  additions = final: _prev: import ../pkgs final.pkgs;
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
