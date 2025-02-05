{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugin-kvantum
    gruvbox-kvantum

    kdePackages.qt6ct
    libsForQt5.qt5ct
  ];

  # home.sessionVariables = {
  #   XDG_CURRENT_DESKTOP = "kde"; # Fixes some apps like dolphin
  # };

  qt = {
    enable = true;
    style.name = "kvantum";
  };
  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Gruvbox-Dark-Brown
  '';
}
