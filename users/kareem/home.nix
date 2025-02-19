{ pkgs, ... }:
{
  imports = [
    ./mpv.nix
    ./ags.nix
    ./fuzzel.nix
    ./rofi.nix
    ./firefox.nix
    # ./dunst.nix

    ./desktops
    ./cmdline
    ./theming
  ];
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = "feh.desktop";
      "image/jpeg" = "feh.desktop";
      "image/jpg" = "feh.desktop";
    };
  };
  programs.go.enable = true;
  home = {
    username = "kareem";
    homeDirectory = "/home/kareem";

    stateVersion = "24.05";

    packages = with pkgs; [
      miru
      stremio
      qbittorrent-enhanced
      fastfetch # NEED TO FLEX
      # adwaita-qt
      # adwaita-qt6
      gparted
      xorg.xhost
      thunderbird
      just
      gimp
      krita
      inkscape
      tlrc
    ];
    file = { };
    sessionVariables = {
      HYPRCURSOR_SIZE = 24;
      XCURSOR_SIZE = 24;
    };
    pointerCursor = {
      name = "Bibata-Nord";
      package = pkgs.bibata-nord;
      size = 24;
      x11.enable = true;
      gtk.enable = true;
    };
  };
}
