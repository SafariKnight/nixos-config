{
  inputs,
  self,
  lib,
  withSystem,
  ...
}: let
  inherit (inputs) nixpkgs;
  inherit (lib.attrsets) recursiveUpdate;
  inherit (lib.lists) flatten singleton;
  inherit (lib.modules) mkDefault;
  mkSystem = nixpkgs.lib.nixosSystem;

  mkNixosSystem = {
    system,
    hostname,
    specialArgs ? {},
    modules ? [],
    ...
  } @ args:
    withSystem system (
      {
        inputs',
        self',
        ...
      }:
        mkSystem {
          specialArgs =
            recursiveUpdate {
              inherit inputs' self' inputs self;
            }
            specialArgs;
          modules = flatten [
            (singleton {
              networking.hostName = hostname;
              nixpkgs = {
                hostPlatform = system;
                flake.source = nixpkgs.outPath;
              };
            })
            modules
          ];
        }
    );
in {
  inherit mkNixosSystem;
}
