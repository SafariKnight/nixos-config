{
  pkgs,
  lib,
  config,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    settings = {
      monitor = [ "HDMI-A-1,1920x1080@144.00,0x0,1" ];
      debug = {
        disable_logs = false; # why is this disabled by default
      };
      exec-once = [
        "{pkgs.dunst}/bin/dunst"
      ];
      general = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = 2;
        gaps_out = 3;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "dwindle";

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = true;
      };
      misc = {
        force_default_wallpaper = 0;
      };
      decoration = {
        rounding = 0;
        blur = {
          enabled = true;
          size = 8;
          passes = 1;
        };

        drop_shadow = "yes";
        shadow_range = 2;
        shadow_render_power = 10;
        "col.shadow" = "rgba(1a1a1aee)";
      };
      animations = {
        enabled = true;
        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92 "
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.38, 0.04, 1, 0.07"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
          "softAcDecel, 0.26, 0.26, 0.15, 1"
          "md2, 0.4, 0, 0.2, 1" # use with .2s duration
        ];

        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "windowsIn, 1, 3, md3_decel, popin 60%"
          "windowsOut, 1, 3, md3_accel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 3, md3_decel"
          "layers, 1, 2, md3_decel"
          "layersIn, 1, 3, menu_decel, slide top"
          "layersOut, 1, 1.6, menu_accel, popin"
          "fadeLayersIn, 1, 2, menu_decel"
          "fadeLayersOut, 1, 4.5, menu_accel"
          "workspaces, 1, 7, menu_decel, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };
      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };
      input = {
        kb_layout = "cmk,ara,us";
        kb_options = "grp:win_space_toggle,altwin:menu_win";
        repeat_rate = 60;
        repeat_delay = 400;
        accel_profile = "flat";
        sensitivity = 0;
      };
      windowrulev2 = [
        "workspace 1, class:(LibreWolf)"
        "workspace 1, class:(firefox)"
        "workspace 2, class:(kitty)"
        "workspace 2, class:(com.stremio.stremio)"
        "workspace 3, class:(mpv)"
        "fullscreen, class:(mpv)"
        "workspace 4, class:(vesktop)"
        "workspace 10, class:(lutris)"

        "suppressevent maximize, class:.*"

        # Clipse
        "float,class:(clipse)"
        "size 622 652,class:(clipse)"

        # Yazi
        "float,class:(yazi)"
        "size 1280 720,class:(yazi)"
      ];
      layerrule = [
        # Remove Grimblast animation
        "noanim, selection"
        "noanim, hyprpicker"
        # Remove Wallpaper animations
        "noanim, swww-daemon"
        "noanim, wallpaper"

        # Ags Animations
        "animation slide top, audio-flyout"
        "animation slide right, notifications"
      ];
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$terminalFileManager" = "$terminal --class yazi -e \"yazi\"";
      "$browser" = "firefox";
      "$menu" = "rofi -show drun | xargs hyprctl dispatch exec";
      bind = [
        # Global Shortcuts
        ",F10,pass,vesktop"

        "$mod, T, exec, $terminal"
        "$mod, Q, killactive, "
        "$mod SHIFT, Q, exec, wlogout"
        "$mod SHIFT CTRL, Q, exit,"
        "$mod, E, exec, $terminalFileManager"
        "$mod SHIFT, E, exec, $fileManager"
        "$mod, V, togglefloating, "
        "$mod, R, exec, $menu"
        "$mod, W, exec, $browser"
        "$mod SHIFT, R, exec, $menu_alt"
        "$mod, P, pseudo,"
        "$mod, S, togglesplit,"

        # Move focus with mod + hjkl
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        # Move window with mod Shift + hjkl
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, l, movewindow, r"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, j, movewindow, d"

        # Resize with mod Ctrl + hjkl
        "$mod CTRL, h, resizeactive, -20 0"
        "$mod CTRL, l, resizeactive, 20 0"
        "$mod CTRL, k, resizeactive, 0 -20"
        "$mod CTRL, j, resizeactive, 0 20"

        # Dwindle Layout Groups
        "$mod, g, togglegroup,"
        "$mod, tab, changegroupactive,"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        "$mod, grave, togglespecialworkspace, magic"
        "$mod SHIFT, grave, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        # Screenshot
        "$mod, Print, exec, grimblast copysave screen $(xdg-user-dir PICTURES)/Screenshots/$(date +%Y-%m-%d_%H:%M:%S%Z).png"
        "        , Print, exec, grimblast --freeze copysave area $(xdg-user-dir PICTURES)/Screenshots/$(date +%Y-%m-%d_%H:%M:%S%Z).png"
        # Fullscreen
        "$mod, F, fullscreen"

        # Zoom
        "$mod, Z, fullscreenstate, 3"

        # Reload waybar
        "$mod SHIFT, P, exec, killall waybar;waybar -l off &"
        # "$mod SHIFT, P, exec, killall gBar;gBar bar HDMI-A-1 &"

        # Clipboard
        "$mod SHIFT, V, exec,  $terminal --class clipse -e 'clipse' "

        # Switch Wifi Connections (Script not in repo)
        "$mod SHIFT, Y, exec, /home/kareem/.local/bin/chwifi"

        # Color Picker
        "$mod SHIFT, M, exec, wl-color-picker"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
