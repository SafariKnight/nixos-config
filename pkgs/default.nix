pkgs: {
  bibata-nord = pkgs.callPackage ./bibata-nord.nix { };
  gandhi-sans = pkgs.callPackage ./gandhi-sans.nix { };
  gopeed = pkgs.callPackage ./gopeed.nix { };

  rofi-logout = pkgs.callPackage ./scripts/rofi-logout.nix { };
  # berkeley-mono = pkgs.callPackage ./berkeley-mono.nix {};
}
