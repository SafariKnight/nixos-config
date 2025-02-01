{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
    };
    iconTheme = {
      name = "breeze-dark";
      package = pkgs.kdePackages.breeze-icons;
    };
    # cursorTheme = {
    #   name = "Bibata-Nord";
    #   package = pkgs.bibata-nord;
    #   size = 24;
    # };
  };

  # home.packages = with pkgs; [
  #   gruvbox-gtk-theme
  # ];
}
