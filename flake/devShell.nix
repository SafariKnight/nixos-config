{
  perSystem = {
    # config,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShellNoCC {
      packages = with pkgs; [
        lua
        luajit
        lua-language-server
        stylua
        nixd
        alejandra
      ];
    };
  };
}
