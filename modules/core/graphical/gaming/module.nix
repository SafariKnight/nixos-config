{...}: {
  imports = builtins.trace "gayming" [
    ./emulation.nix
    ./lutris.nix
    ./prismlauncher.nix
    ./steam.nix
    ./wine.nix
  ];
}