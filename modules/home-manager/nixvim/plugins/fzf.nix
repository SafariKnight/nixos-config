{ ... }:
{
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
          builtin = { };
        };
      };
    };
  };
}
