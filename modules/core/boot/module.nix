{...}: {
  imports = builtins.trace "boot trace" [
    ./greetd.nix
    ./plymouth.nix
    ./sddm.nix
    ./systemd-boot.nix
  ];
}
