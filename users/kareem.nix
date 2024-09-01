{ pkgs, inputs, ... }:

{
  imports = [
    ./../modules/home-manager
  ];
  qt = {
    enable = true;
    # platformTheme = "kde";
  };
  programs.home-manager.enable = true;
  home = {
    username = "kareem";
    homeDirectory = "/home/kareem";
    stateVersion = "24.05";

    packages = with pkgs; [
      miru
      stremio
      qbittorrent-enhanced
      fastfetch # NEED TO FLEX
    ];
    file = { };
    sessionVariables = {
      HYPRCURSOR_SIZE = 24;
      XCURSOR_SIZE = 24;
      QT_QPA_PLATFORMTHEME = "qt6ct";
    };
    pointerCursor = {
      x11.enable = true;
      gtk.enable = true;
    };
  };
}
