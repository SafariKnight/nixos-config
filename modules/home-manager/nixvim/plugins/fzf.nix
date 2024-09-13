{...}: {
  programs.nixvim.plugins = {
    fzf-lua = {
      enable = true;
      keymaps = {
        "<leader><space>" = {
          action = "files";
          # settings = {
          #   files = {
          #     find_opts.__raw = "fd --type f";
          #   };
          # };
        };
      };
      settings = {
        winopts = {
          preview = {
            border = "noborder";
            vertical = "up:45%";
          };
        };
        previewers = {
          builtin = {};
        };
      };
    };
    dressing = {
      enable = true;
      settings = {
        input.enabled = true;
        select = {
          backend = [
            "fzf_lua"
            "fzf"
            "nui"
            "builtin"
          ];
          enabled = true;
        };
      };
    };
  };
}
