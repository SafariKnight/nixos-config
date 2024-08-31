{ lib, ... }:
{
  imports = [
    ./keyboard.nix
    ./pipewire.nix
  ];
  modules = {
    # Keep these modules enabled by default and have them be togglable
    cmk-keyboard.enable = lib.mkDefault true;
    pipewire.enable = lib.mkDefault true;
  };
}
