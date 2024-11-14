{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [./../modules/home-manager];
  programs.home-manager.enable = true;

  gtk = {
    iconTheme.name = "Papirus-Dark";
    iconTheme.package = pkgs.papirus-nord;
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
      (zoom-us.overrideAttrs (old: {
        postFixup =
          old.postFixup
          + ''
            wrapProgram $out/bin/zoom --unset XDG_SESSION_TYPE
            wrapProgram $out/bin/zoom-us --unset XDG_SESSION_TYPE
          '';
      }))
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
