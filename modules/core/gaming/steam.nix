{...}: {
  programs.steam = {
    enable = true;
    protontricks.enable = true;
  };
  services.dnsmasq = {
    enable = true;
  };
}
