{...}: {
  imports = builtins.trace "graphical root trace" [
    ./pipewire.nix
  ];
}
