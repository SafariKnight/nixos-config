# Unfinished
{ pkgs, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    package = pkgs.swayfx;

    checkConfig = false;
    config = {
      menu = "rofi -show drun | xargs swaymsg exec --";
      terminal = "footclient";
      modifier = "Mod4"; # Super key
      input = {
        "*" = {
          accel_profile = "flat";
          xkb_layout = "cmk,ara,us";
          xkb_options = "grp:win_space_toggle,altwin:menu_win";
          repeat_delay = "400";
          repeat_rate = "60";
        };
      };
      output = {
        "DP-1" = {
          mode = "1920x1080@165.003Hz";
        };
      };
    };
  };
}
