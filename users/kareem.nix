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
      HYPRCURSOR_SIZE = 24;
      XCURSOR_SIZE = 24;
      QT_QPA_PLATFORMTHEME = "qt6ct";
    };

    pointerCursor = {
      name = "Bibata-Nord";
      # name = "default";
      package = pkgs.bibata-nord;
      size = 24;
      x11.enable = true;
      gtk.enable = true;
    };
  };
}
