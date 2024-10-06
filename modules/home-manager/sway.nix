# Unfinished
{pkgs, ...}: {
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;

    checkConfig = false;
    config = {
      menu = "rofi -show drun | xargs swaymsg exec --";
      terminal = "ghostty";
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
        "HDMI-A-1" = {
          mode = "1920x1080@144Hz";
        };
      };
    };
  };
}
