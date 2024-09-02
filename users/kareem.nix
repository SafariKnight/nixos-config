{ pkgs, inputs, ... }:

{
  imports = [
    ./../modules/home-manager
  ];
  qt = {
    enable = true;
    platformTheme.name = "gtk";
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
      kdePackages.breeze-icons
      kdePackages.qtsvg

    ];
    file = { };
    sessionVariables = {
      HYPRCURSOR_SIZE = 24;
      XCURSOR_SIZE = 24;
    };
    pointerCursor = {
      x11.enable = true;
      gtk.enable = true;
    };
  };
}
