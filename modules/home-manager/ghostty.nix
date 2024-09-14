{
  lib,
  inputs,
  pkgs,
  ...
}: {
  xdg.configFile."ghostty/config".text = lib.generators.toKeyValue {listsAsDuplicateKeys = true;} {
    # Window
    background-opacity = 0.9;
    window-decoration = false;

    # Cursor
    cursor-style-blink = false;
    adjust-cursor-thickness = 1;
    shell-integration-features = "no-cursor, sudo, title";

    # Font
    font-family = "JetBrains Mono";
    font-style = "SemiBold";
    font-style-bold = "Bold";
    font-style-italic = "SemiBold Italic";
    font-style-bold-italic = "Bold Italic";
    font-size = 12;

    # Colors
    theme = "nord";
  };
}
