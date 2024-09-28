{
  pkgs,
  config,
  ...
}: {
  imports = [./../modules/home-manager];
  qt = {
    enable = true;
    style.name = "adwaita";
  };
  programs.home-manager.enable = true;

  gtk = {
    iconTheme.name = "Papirus";
    iconTheme.package = pkgs.papirus-nord;
    enable = true;
  };
  home = {
    username = "kareem";
    homeDirectory = "/home/kareem";
    stateVersion = "24.05";

    packages = with pkgs; [
      miru
      stremio
      qbittorrent-enhanced
      fastfetch # NEED TO FLEX
      adwaita-qt
      adwaita-qt6
      gparted
      xorg.xhost
      prismlauncher
      # libsForQt5.qtstyleplugins
      # kdePackages.breeze-icons
      # kdePackages.qtsvg
      tlrc
    ];
    file = {};
    sessionVariables = {
      HYPRCURSOR_SIZE = 24;
      XCURSOR_SIZE = 24;
    };
    pointerCursor = {
      # name = "bibata-nord";
      # package = pkgs.bibata-nord;
      x11.enable = true;
      gtk.enable = true;
    };
  };
}
