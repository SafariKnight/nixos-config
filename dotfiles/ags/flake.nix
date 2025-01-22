{
  description = "My Awesome Desktop Shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ags,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    agsPkgs = ags.packages.${system};
  in {
    packages.${system} = {
      default = ags.lib.bundle {
        inherit pkgs;
        src = ./.;
        name = "ags-shell";
        entry = "app.ts";

        # additional libraries and executables to add to gjs' runtime
        extraPackages = [
          # ags.packages.${system}.battery
          # pkgs.fzf
          pkgs.graphene
          pkgs.gtk4
          pkgs.dart-sass
        ];
      };
    };

    devShells.${system} = {
      default = pkgs.mkShell {
        buildInputs = [
          # LSP
          pkgs.typescript-language-server
          pkgs.typescript
          pkgs.vscode-langservers-extracted
          pkgs.emmet-language-server

          pkgs.nodejs_20.pkgs.prettier

          pkgs.dart-sass

          # includes astal3 astal4 astal-io by default
          (agsPkgs.default.override {
            extraPackages = [
              agsPkgs.io
              agsPkgs.hyprland
            ];
          })
        ];

        env = {
          TSSERVERJS = "${pkgs.typescript}/lib/node_modules/typescript/lib";
        };
      };
    };
  };
}
