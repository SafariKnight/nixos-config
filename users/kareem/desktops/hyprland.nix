{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    grimblast
    hyprpicker
    hyprpolkitagent
  ];
  programs.hyprlock = {
    enable = false; # Still gotta integrate it better
    settings = {
      general = {
        grace = 300;
        no_fade_in = false;
      };
      background = [
        {
          path = "${config.home.homeDirectory}/nixos-config/users/kareem/desktops/wallpaper.png";
        }
      ];
      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          outer_color = "rgb(24, 25, 38)";
          outline_thickness = 5;
          placeholder_text = "\'<span foreground=\"##cad3f5\">Password...</span>\'";
          shadow_passes = 2;
        }
      ];
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    settings = {
      monitor = ["DP-1,1920x1080@165.003,0x0,1"];
      debug = {
        disable_logs = false; # why is this disabled by default
      };
      exec-once = [
        "systemctl --user start hyprpolkitagent"
        "swaybg -i ${config.home.homeDirectory}/nixos-config/users/kareem/desktops/wallpaper.png"
      ];
      general = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = 2;
        gaps_out = 3;
        border_size = 2;
        "col.active_border" = "rgba(5e81acee) rgba(81a1c1ee) 45deg";
        "col.inactive_border" = "rgba(d8dee9aa)";

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
        shadow = {
          enabled = true;
          range = 2;
          render_power = 10;
          color = "rgba(1a1a1aee)";
        };
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
          "workspaces, 0"
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
        "workspace 2, class:(ghostty)"
        "workspace 2, class:(com.stremio.stremio)"
        "workspace 3, class:(mpv)"
        "fullscreen, class:(mpv)"
        "workspace 4, class:(vesktop)"
        "workspace 10, class:(lutris)"

        "opacity 0.0 override, class:^(xwaylandvideobridge)$"
        "noanim, class:^(xwaylandvideobridge)$"
        "noinitialfocus, class:^(xwaylandvideobridge)$"
        "maxsize 1 1, class:^(xwaylandvideobridge)$"
        "noblur, class:^(xwaylandvideobridge)$"
        "nofocus, class:^(xwaylandvideobridge)$"

        "suppressevent maximize, class:.*"

        "float,class:(term.applet)"
        "size 622 652,class:(term.applet)"

        "float,class:(term.app)"
        "size 1280 720,class:(term.app)"

        "float,class:(org.pulseaudio.pavucontrol)"
        "size 1280 720,class:(org.pulseaudio.pavucontrol)"
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
      "$terminal" = "ghostty";
      "$fileManager" = "thunar";
      "$browser" = "firefox";
      "$menu" = "rofi -show drun | xargs hyprctl dispatch exec";

      bind = [
        ### Global Shortcuts ###
        ",F10,pass,vesktop"

        ### Windows ###
        "$mod, Q, killactive, " # Close windows
        "$mod, Z, fullscreenstate, 1" # Zoom
        "$mod, F, fullscreen"

        # Alternate Layouts #
        "$mod, V, togglefloating, "
        "$mod, P, pseudo,"
        "$mod, S, togglesplit,"

        # Move between Windows #
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        # Move Windows #
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, l, movewindow, r"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, j, movewindow, d"

        # Resize Windows #
        "$mod CTRL, h, resizeactive, -20 0"
        "$mod CTRL, l, resizeactive, 20 0"
        "$mod CTRL, k, resizeactive, 0 -20"
        "$mod CTRL, j, resizeactive, 0 20"

        # Dwindle Layout Groups # imma be honest, I don't use these
        "$mod, g, togglegroup,"
        "$mod, tab, changegroupactive,"

        ### Workspaces ###

        # Switch Workspaces #
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
        "$mod, grave, togglespecialworkspace, magic" # Scratchpad
        # Mouse controls
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        # Move Windows to Workspaces #
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
        "$mod SHIFT, grave, movetoworkspace, special:magic" # Scratchpad

        ### Apps ###
        "$mod SHIFT, Q, exec, rofi-logout"
        "$mod SHIFT CTRL, Q, exit,"
        "$mod SHIFT, E, exec, $fileManager"
        "$mod, W, exec, $browser"
        "$mod, R, exec, $menu"

        # Audio #
        "$mod ALT, P, exec, pavucontrol"

        # Screenshots #
        "$mod, Print, exec, grimblast copysave screen $(xdg-user-dir)/Pictures/Screenshots/$(date +%Y-%m-%d_%H:%M:%S%Z).png"
        "    , Print, exec, grimblast --freeze copysave area $(xdg-user-dir)/Pictures/Screenshots/$(date +%Y-%m-%d_%H:%M:%S%Z).png"

        # Info via Notifications #
        ''$mod SHIFT, U, exec, notify-send --icon clock-symbolic "$(date)"'' # Time

        # Terminal Apps #
        "$mod, T, exec, $terminal" # Terminal
        "$mod, E, exec, $terminal --class=term.app -e 'yazi' " # Yazi (File Manager)
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
