{inputs, ...}: {
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
      "https://aseipp-nix-cache.global.ssl.fastly.net"
    ];
    settings.trusted-public-keys = [
      # "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
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
