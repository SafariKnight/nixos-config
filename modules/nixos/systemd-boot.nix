{
  lib,
  config,
  ...
}: {
  options = {
    modules.systemd-boot.enable = lib.mkEnableOption "Enable systemd-boot";
  };
  config = lib.mkIf config.modules.systemd-boot.enable {
    boot.loader = {
      timeout = lib.mkDefault 0;
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        editor = false;
        configurationLimit = 100;
      };
    };
  };
}
