{ pkgs, ... }:
{
  gtk = {
    iconTheme.name = "Adwaita";
    iconTheme.package = pkgs.adwaita-icon-theme;
    cursorTheme = {
      name = "Bibata-Nord";
      package = pkgs.bibata-nord;
      size = 24;
    };
    enable = true;
  };
}
