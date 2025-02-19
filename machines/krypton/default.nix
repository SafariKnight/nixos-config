{
  pkgs,
  config,
  modulesPath,
  lib,
  ...
}:
let
  mainUser = "kareem";
in
{
  imports = [
    ./autoUpgrade.nix
    ./boot.nix
    ./locale.nix
    ./mounts.nix
    ./network.nix
    ./options.nix
    ./packages.nix

    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  system.stateVersion = "24.05";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware = {
    usb-modeswitch.enable = true;
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  qt = {
    enable = true;
    style = "kvantum";
  };

  users.users.${mainUser} = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "uinput"
      "kvm"
      "libvirt"
    ];
    shell = pkgs.bash;
  };
}
