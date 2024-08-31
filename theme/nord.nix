{ stylix, pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    image = ./nord.png;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    cursor = {
      name = "Bibata-Nord";
      package = pkgs.bibata-nord;
      size = 24;
    };

    # rofi.enable = false;
    targets.nixvim.enable = false;
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
