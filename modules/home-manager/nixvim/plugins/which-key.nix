{...}: {
  programs.nixvim.plugins = {
    which-key = {
      enable = true;
      settings.preset = "modern";
      settings.spec = [
        {
          __unkeyed-1 = "<leader>c";
          group = "code";
        }
        {
          __unkeyed-1 = "<leader>f";
          group = "find";
        }
        {
          __unkeyed-1 = "cr";
          group = "refactor";
        }
      ];
      settings.icons = {
        breadcrumb = "";
        separator = " ";
        group = "+";
      };
    };
  };
}
