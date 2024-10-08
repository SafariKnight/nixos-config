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
    # font-family = "Berkeley Mono";
    font-family = "Iosevka";

    # font-family = "JetBrains Mono";
    # font-style = "SemiBold";
    # font-style-bold = "Bold";
    # font-style-italic = "SemiBold Italic";
    # font-style-bold-italic = "Bold Italic";
    font-size = 13;

    keybind = [
      "ctrl+j=goto_split:bottom"
      "ctrl+k=goto_split:top"
      "ctrl+l=goto_split:right"
      "ctrl+h=goto_split:left"
    ];

    # Colors
    theme = "nord";
  };
}
