{
  lib,
  inputs,
  self,
  withSystem,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (lib.lists) flatten forEach;
    inherit
      (builtins)
      filter
      map
      toString
      elem
      ;
    inherit (lib.filesystem) listFilesRecursive;
    inherit (lib.strings) hasSuffix;

    mkModuleTree = {
      path,
      ignoredPaths ? [./default.nix],
    }:
      filter (hasSuffix "module.nix") (
        map toString (
          # List all files in the given path, and filter out paths that are in
          # the ignoredPaths list
          filter (path: !elem path ignoredPaths) (listFilesRecursive path)
        )
      );
    mkModulesFor = hostname: {
      modules ? [],
      extraModules ? [],
      ignoredPaths ? [],
      defaultModules ? [
        options
        nixModule
        boot
      ],
    }:
      flatten [
        ./${hostname}/default.nix
        ./${hostname}/hardware.nix
        (forEach modules (path: mkModuleTree {inherit path ignoredPaths;}))
        (forEach defaultModules (path: mkModuleTree {inherit path ignoredPaths;}))
        extraModules
      ];

    stylix = inputs.stylix.nixosModules.stylix;
    nordTheme = ../theme/nord.nix;

    hm = inputs.home-manager.nixosModules.home-manager;
    homes = ../users;

    home = [
      hm
      homes
    ];
    nord = [
      stylix
      nordTheme
    ];

    modules = ../modules;
    coreModules = modules + /core;
    options = modules + /options;

    boot = coreModules + /boot;
    graphical = coreModules + /graphical;
    nixModule = coreModules + /nix;

    inherit (import ./mkNixosSystem.nix {inherit lib withSystem inputs self;}) mkNixosSystem;
  in {
    krypton = mkNixosSystem {
      hostname = "krypton";
      system = "x86_64-linux";
      modules = mkModulesFor "krypton" {
        modules = [graphical];
        extraModules = [
          home
          nord
        ];
      };
    };
  };
}
