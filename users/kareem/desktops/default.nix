{ pkgs, ... }:
{
  imports = [
    # ./niri.nix
    ./hyprland.nix
    ./sway.nix
  ];
  services.swaync.enable = true;
  home.packages = with pkgs; [
    clipse
    pavucontrol
    swaybg
    rofi-logout
  ];
}
