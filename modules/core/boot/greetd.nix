{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.boot.greetd;
in {
  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = let
          tuigreet = "${lib.getExe pkgs.greetd.tuigreet}";
          baseSessions = "${config.services.displayManager.sessionData.desktops}";
          xSessions = "${baseSessions}/share/xsessions";
          waylandSessions = "${baseSessions}/share/wayland-sessions";
          tuigreetOptions = [
            "--remember"
            "--remember-session"
            "--sessions ${waylandSessions}:${xSessions}"
            "--time"
            # Make sure theme is wrapped in single quotes. See https://github.com/apognu/tuigreet/issues/147
            "--theme 'border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red'"
            "--cmd ${cfg.command}"
          ];
          flags = lib.concatStringsSep " " tuigreetOptions;
        in {
          command = "${tuigreet} ${flags}";
          user = "greeter";
        };
      };
    };
  };
}
