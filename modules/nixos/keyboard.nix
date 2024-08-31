{ config, lib, ... }:
{
  options = {
    modules.cmk-keyboard.enable = lib.mkEnableOption "Set Keyboard Layout to Colemak CAWS";
  };
  config = lib.mkIf config.modules.cmk-keyboard.enable {
    services.xserver.xkb.extraLayouts.cmk = {
      description = "Colemak DH with Wide and Symbol mods (Colemak CAWS)";
      symbolsFile = ./../../assets/cmk;
      languages = [ "eng" ];
    };
    services.xserver.xkb = {
      layout = "us";
      variant = "colemak_dh_wide_symbol";
    };
  };
}
