{ pkgs, inputs, ... }:

{
  imports = [
    ./../modules/home-manager
  ];
  home.username = "kareem";
  home.homeDirectory = "/home/kareem";
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";

  home.packages = [ ];
  home.file = { };
  home.sessionVariables = {
    HYPRCURSOR_SIZE = 32;
    XCURSOR_SIZE = 32;
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };
}
