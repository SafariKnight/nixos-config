{
  userName,
  config,
  lib,
  ...
}: {
  options = {
    modules.greetd.enable = lib.mkEnableOption "Enable Greetd Autologin";
    modules.greetd.command = lib.mkOption {
      description = lib.mdDoc "Command to run on startup";
      default = "hyprland";
      type = lib.types.str;
    };
  };
  config = lib.mkIf config.modules.greetd.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "$agreety --cmd bash";
          user = "${userName}";
        };
        initial_session = {
          command = "${config.modules.greetd.command} >/dev/null";
          user = "${userName}";
        };
      };
    };
  };
}
