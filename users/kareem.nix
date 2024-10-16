{
  pkgs,
  config,
  ...
}: {
  imports = [./../modules/home-manager];
  programs.home-manager.enable = true;

  # stylix.targets.gtk.enable = true;
  gtk = {
    iconTheme.name = "Papirus-Dark";
    iconTheme.package = pkgs.papirus-nord;
    enable = true;
  };

  qt = {
    enable = true;

    platformTheme.name = "gtk2";
    # platformTheme.package = pkgs.qtstyleplugins;

    style.name = "gtk2";
    # style.package = pkgs.qtstyleplugins;
  };
  # gtk = {
  #   theme = {
  #     package = pkgs.nordic;
  #     name = "nordic";
  #   };
  #   iconTheme.name = "Papirus";
  #   iconTheme.package = pkgs.papirus-nord;
  #   enable = true;
  # };
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
      thunderbird
      # libsForQt5.qtstyleplugins
      # kdePackages.breeze-icons
      # kdePackages.qtsvg
      gimp
      krita
      inkscape
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
