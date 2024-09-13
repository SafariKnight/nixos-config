{...}: {
  programs.nixvim.plugins = {
    mini = {
      enable = true;
      modules = {
        ai = {};
        pairs = {};
        surround = {
          mappings = {
            add = "gza";
            delete = "gzd";
            find = "gzf";
            find_let = "gzF";
            highlight = "gzh";
            replace = "gzr";
            update_n_lines = "gzn";

            suffix_last = "l";
            suffix_next = "n";
          };
        };
      };
    };
  };
}
