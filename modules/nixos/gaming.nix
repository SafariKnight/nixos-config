{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    modules.gaming.enable = lib.mkEnableOption "Enable Gaming Things";
  };
  config = lib.mkIf config.modules.gaming.enable {
    programs.steam.enable = true;
    programs.steam.protontricks.enable = true;
    environment.systemPackages = with pkgs; [
      lutris
      wine
      wine64
      winetricks
    ];
  };
}
