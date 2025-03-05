{
  inputs,
  config,
  lib,
  ...
}:
{
  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      extraOptions = "warn-dirty = false";
      gc.automatic = false;
      optimise = {
        automatic = true;
        dates = [ "weekly" ];
      };
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
        ];
        substituters = [
          "https://cosmic.cachix.org/"
          "https://ghostty.cachix.org/"
          "https://aseipp-nix-cache.global.ssl.fastly.net/"
          "https://winapps.cachix.org/"
          "https://hyprland.cachix.org/"
        ];
        trusted-public-keys = [
          "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
          "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
          "winapps.cachix.org-1:HI82jWrXZsQRar/PChgIx1unmuEsiQMQq+zt05CD36g="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        ];
        trusted-users = [ "@wheel" ];
        flake-registry = "";
        nix-path = config.nix.nixPath;
      };
      channel.enable = false;
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

  nixpkgs = {
    overlays = [
      inputs.nur.overlays.default
      (final: _prev: import ./../../../pkgs final.pkgs)
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
    config = {
      allowUnfree = true;
    };
  };
}
