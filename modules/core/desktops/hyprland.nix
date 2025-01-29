{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.desktop.hyprland;
in
{
  config = lib.mkIf cfg.enable {
    programs.hyprland.enable = true;
    programs.hyprland.withUWSM = cfg.uwsm;
    modules.desktop.hyprland.keyPrefix = lib.mkOverride 150 (if cfg.uwsm then "uwsm app -- " else "");
    security.polkit.enable = true;
  };
}
