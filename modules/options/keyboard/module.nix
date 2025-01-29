{
  config,
  lib,
  ...
}:
{
  options = {
    modules.keyboard.keyd.enable = lib.mkEnableOption "Enable Keyd";
    modules.keyboard.kanata.enable = lib.mkEnableOption "Enable Kanata";
  };
  config = {
    assertions = [
      {
        assertion = !(config.modules.keyboard.keyd.enable && config.modules.keyboard.kanata.enable);
        message = "keyd and kanata aren't compatable with each other";
      }
    ];
    modules.keyboard.keyd.enable = lib.mkDefault true;
    modules.keyboard.kanata.enable = lib.mkDefault false;
  };
}
