{
  userName,
  config,
  lib,
  ...
}:
{
  options = {
    modules.greetd.enable = lib.mkEnableOption "Enable Greetd Autologin";
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
          command = "hyprland > /dev/null";
          user = "${userName}";
        };
      };
    };
  };
}
