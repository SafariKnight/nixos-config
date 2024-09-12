{ lib, ... }:
{
  imports = [
    ./keyboard.nix
    ./pipewire.nix
    ./nh.nix
    ./greetd.nix
  ];
  modules = {
    # Keep these modules enabled by default and have them be togglable
    cmk-keyboard.enable = lib.mkDefault true;
    pipewire.enable = lib.mkDefault true;
    nh.enable = lib.mkDefault true;
    greetd.enable = lib.mkDefault true;
  };
}
