{
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.modules.desktop.plasma.enable {
    services.desktopManager.plasma6.enable = true;
  };
}
