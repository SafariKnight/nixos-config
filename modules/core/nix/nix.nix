{ inputs, ... }:
{
  nix = {
    extraOptions = "warn-dirty = false";
    gc.automatic = false;
    optimise.automatic = true;
    optimise.dates = [ "weekly" ];

    settings.cores = 8;
    settings.max-jobs = 16;
    settings.use-xdg-base-directories = true;
    settings.experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];
    settings.substituters = [
      # "https://cosmic.cachix.org/"
      "https://ghostty.cachix.org/"
      "https://aseipp-nix-cache.global.ssl.fastly.net"
      "https://winapps.cachix.org/"
    ];
    settings.trusted-public-keys = [
      # "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
      "winapps.cachix.org-1:HI82jWrXZsQRar/PChgIx1unmuEsiQMQq+zt05CD36g="
    ];
    settings.trusted-users = [
      "root"
      "@wheel"
    ];
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
