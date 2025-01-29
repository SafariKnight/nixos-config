{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.modules.boot.sddm.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}
