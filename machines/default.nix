{
  lib,
  inputs,
  self,
  withSystem,
  ...
}:
{
  flake.nixosConfigurations =
    let
      inherit (lib.lists) flatten;
      inherit (builtins)
        filter
        map
        toString
        elem
        ;
      inherit (lib.filesystem) listFilesRecursive;
      inherit (lib.strings) hasSuffix;

      mkModuleTree =
        {
          path,
          ignoredPaths ? [ ./default.nix ],
        }:
        (
          listFilesRecursive path
          |> filter (path: !elem path ignoredPaths)
          |> map toString
          |> filter (hasSuffix "module.nix")
        );
      mkModulesFor =
        hostname:
        {
          modules ? [ ],
          extraModules ? [ ],
          ignoredPaths ? [ ],
          defaultModules ? [
            options
            nixModule
            boot
          ],
        }:
        flatten [
          ./${hostname}/default.nix
          # ./${hostname}/hardware.nix
          (flatten modules |> map (path: mkModuleTree { inherit path ignoredPaths; }))
          (defaultModules |> map (path: mkModuleTree { inherit path ignoredPaths; }))
          extraModules
        ];

      hm = inputs.home-manager.nixosModules.home-manager;
      homes = ../users;

      home = [
        hm
        homes
      ];
      modules = ../modules;
      coreModules = modules + /core;
      options = modules + /options;

      boot = coreModules + /boot;
      compat = coreModules + /compat;
      desktops = coreModules + /desktops;
      gaming = coreModules + /gaming;
      keyboard = coreModules + /keyboard;

      graphical = [
        compat
        gaming
        desktops
        keyboard
      ];

      nixModule = coreModules + /nix;

      inherit
        (import ./mkNixosSystem.nix {
          inherit
            lib
            withSystem
            inputs
            self
            ;
        })
        mkNixosSystem
        ;
    in
    {
      krypton = mkNixosSystem {
        hostname = "krypton";
        system = "x86_64-linux";
        modules = mkModulesFor "krypton" {
          modules = [ graphical ];
          extraModules = [
            home
          ];
        };
      };
    };
}
