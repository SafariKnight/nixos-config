{...}: {
  imports = builtins.trace "graphical keyboard trace" [
    ./cmk-caws.nix
    ./kanata.nix
    ./keyd.nix
  ];
}
