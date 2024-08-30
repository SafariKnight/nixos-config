{ pkgs, inputs, ... }:

{
  imports = [
    ./../modules/home-manager
  ];
  programs.home-manager.enable = true;
  home = {
    username = "kareem";
    homeDirectory = "/home/kareem";
    stateVersion = "24.05";

    packages = [ ];
    file = { };
    sessionVariables = {
      HYPRCURSOR_SIZE = 32;
      XCURSOR_SIZE = 32;
      QT_QPA_PLATFORMTHEME = "qt6ct";
    };

    pointerCursor = {
      name = "Posy_Cursor_Black";
      size = 32;
      package = pkgs.posy-cursors;
      x11.enable = true;
      gtk.enable = true;
    };
  };
}
