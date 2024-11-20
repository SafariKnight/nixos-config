{
  config,
  lib,
  ...
}: {
  config = {
    assertions = [
      {
        assertion = !(config.modules.boot.greetd.enable && config.modules.boot.sddm.enable);
        message = "greetd and sddm aren't compatable with each other";
      }
    ];
  };
  options = {
    modules.boot.greetd.enable = lib.mkEnableOption "Enable Greetd Autologin";
    modules.boot.greetd.command = lib.mkOption {
      description = lib.mdDoc "Command to run on startup";
      default = "niri-session";
      type = lib.types.str;
    };
    modules.boot.greetd.startupUser = lib.mkOption {
      description = lib.mdDoc "User with autologin";
      type = lib.types.str;
    };
    modules.boot.sddm.enable = lib.mkEnableOption "Enable SDDM";
  };
}
