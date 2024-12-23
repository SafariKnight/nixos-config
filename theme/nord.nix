{pkgs, ...}: {
  stylix = {
    enable = true;
    autoEnable = false;
    image = ./nord.png;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    homeManagerIntegration.followSystem = true;
    cursor = {
      name = "Bibata-Nord";
      package = pkgs.bibata-nord;
      size = 24;
    };

    targets.gtk.enable = true;
    targets.gnome.enable = true;
    opacity = {
      terminal = 0.9;
    };

    fonts = {
      monospace = {
        name = "JetBrains Mono Medium";
        package = pkgs.jetbrains-mono;
      };
      sansSerif = {
        name = "Inter";
        package = pkgs.inter;
      };

      sizes = {
        terminal = 12;
        popups = 15;
      };
    };
  };
}
