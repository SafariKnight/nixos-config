{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.modules.boot.greetd.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "$agreety --cmd bash";
          user = "${config.modules.boot.greetd.startupUser}";
        };
        initial_session = {
          command = "${config.modules.greetd.command} >/dev/null";
          user = "${config.modules.boot.greetd.startupUser}";
        };
      };
    };
  };
}
