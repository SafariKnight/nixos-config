{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.modules.keyboard.keyd.enable {
    services.keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = ["*"];
          settings = {
            main = {
              capslock = "overload(nav, esc)";
              # esc = "noop"; # I have this so I can get in the habit of pressing capslock over escape

              # a = "overloadt(meta, a, 175)";
              # s = "overloadt(alt, s, 175)";
              # d = "overloadt(shift, d, 175)";
              # f = "overloadt(control, f, 175)";
              #
              # k = "overloadt(control, k, 175)";
              # l = "overloadt(shift, l, 175)";
              # ";" = "overloadt(alt, ;, 175)";
              # "'" = "overloadt(meta, ', 175)";
            };
            # "nav:C" = {
            #   d = "layer(shift)";
            #   f = "layer(control)";
            #
            #   h = "left";
            #   j = "down";
            #   k = "up";
            #   l = "right";
            #
            #   semicolon = "backspace";
            #   p = "delete";
            # };

            # Colemak CAWS
            "nav:C" = {
              d = "layer(shift)";
              f = "layer(control)";

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
