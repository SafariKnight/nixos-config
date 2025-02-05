{ lib, ... }:
{
  networking = {
    hostName = "krypton";
    useDHCP = lib.mkDefault true;
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
    interfaces.wlp9s0f4u1 = {
      mtu = 1478;
      name = "wlan0";
    };
  };
}
