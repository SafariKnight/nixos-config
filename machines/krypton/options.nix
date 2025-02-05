{ ... }:
let
  mainUser = "kareem";
in
{
  modules.boot.greetd.enable = true;
  modules.boot.greetd.command = "Hyprland";
  modules.boot.greetd.startupUser = mainUser;

  modules.desktop.plasma.enable = true;

  modules.desktop.hyprland.enable = true;
  modules.desktop.hyprland.uwsm = true;

  modules.nix.nh.flakePath = "/home/${mainUser}/nixos-config";
}
