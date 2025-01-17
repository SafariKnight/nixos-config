{lib, ...}: {
  options = {
    modules.desktop.plasma.enable = lib.mkEnableOption "Enable KDE Plasma DE";
    modules.desktop.hyprland = {
      enable = lib.mkEnableOption "Enable Hyprland WM";
      uwsm = lib.mkOption {
        description = lib.mdDoc "Launch Hyprland via UWSM";
        type = lib.types.bool;
      };
      keyPrefix = lib.mkOption {
        description = lib.mdDoc "Prefix for all hyprland keybindings";
        type = lib.types.str;
      };
    };
  };
  config = {
    modules.desktop.plasma.enable = lib.mkDefault true;
    modules.desktop.hyprland = {
      enable = lib.mkDefault false;
      uwsm = lib.mkDefault false;
      keyPrefix = lib.mkDefault "";
    };
  };
}
