{pkgs, ...}: {
  imports = [
    ./direnv.nix
    ./firefox.nix
    ./fish.nix
    ./ghostty.nix
    ./git.nix
    ./jujutsu.nix
    ./lazygit.nix
    ./mpv.nix
    ./nvim.nix
    ./hyprland.nix
    ./oh-my-posh.nix
    ./tmux.nix
    ./zellij.nix

    # ./ags.nix
    # ./dunst.nix
    # ./hyprland.nix
    # ./kitty.nix
    # ./mako.nix
    # ./niri.nix
    # ./rofi.nix
    # ./starship.nix
    # ./sway.nix
  ];
  # modules.niri.enable = true;
  gtk = {
    iconTheme.name = "Papirus-Dark";
    iconTheme.package = pkgs.papirus-nord;
    cursorTheme = {
      name = "bibata-nord";
      package = pkgs.bibata-nord;
      size = 24;
    };
    enable = true;
  };
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = "feh.desktop";
      "image/jpeg" = "feh.desktop";
      "image/jpg" = "feh.desktop";
    };
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
      thunderbird
      just
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
      name = "bibata-nord";
      package = pkgs.papirus-nord;
      size = 24;
      x11.enable = true;
      gtk.enable = true;
    };
  };
}
