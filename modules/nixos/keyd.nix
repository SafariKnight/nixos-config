{
  lib,
  config,
  ...
}: {
  options = {
    modules.keyd.enable = lib.mkEnableOption "Enable Keyd";
  };
  config = lib.mkIf config.modules.keyd.enable {
    services.keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = ["*"];
          settings = {
            main = {
              capslock = "overload(nav, esc)";
              esc = "capslock";

              a = "overloadt(meta, a, 175)";
              s = "overloadt(alt, s, 175)";
              d = "overloadt(shift, d, 175)";
              f = "overloadt(control, f, 175)";

              k = "overloadt(control, k, 175)";
              l = "overloadt(shift, l, 175)";
              ";" = "overloadt(alt, ;, 175)";
              "'" = "overloadt(meta, ', 175)";
            };
            nav = {
              j = "left";
              k = "down";
              l = "up";
              semicolon = "right";

              "'" = "backspace";
              leftbrace = "delete";
            };
          };
        };
      };
    };
  };
}
