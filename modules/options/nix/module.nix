{ lib, ... }:
{
  options = {
    modules.nix.nh.flakePath = lib.mkOption {
      description = lib.mdDoc "Path of the flake for nh to use";
      type = lib.types.str;
    };
  };
}
