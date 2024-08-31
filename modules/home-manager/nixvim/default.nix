{ inputs, config, ... }:
let
  helper = config.lib.nixvim;
in
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./options.nix
  ];
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    luaLoader.enable = true;
    performance = {
      byteCompileLua.enable = true;
    };

    viAlias = true;
    vimAlias = true;

    # colorscheme is handled by stylix now
    colorschemes.nord.enable = true;
  };
}
