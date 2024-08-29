{ config, lib, ... }:
{
  options = {
    modules.pipewire.enable = 
      lib.mkEnableOption "Enable Pipewire for Audio";
  };
  config = lib.mkIf config.modules.pipewire.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
