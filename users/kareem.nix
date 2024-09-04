{ pkgs, lib, ... }:
{
  imports = [ ./../modules/home-manager ];
  qt = {
    enable = true;
    # platformTheme.name = "gtk3";
    # platformTheme.name = "gnome";
    style.name = lib.mkForce "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };
  programs.home-manager.enable = true;

  gtk = {
    iconTheme.name = "Papirus";
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
      papirus-nord
      # libsForQt5.qtstyleplugins
      # kdePackages.breeze-icons
      # kdePackages.qtsvg
      tlrc
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
