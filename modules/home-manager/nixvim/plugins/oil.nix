{...}: {
  programs.nixvim.plugins = {
    oil = {
      enable = true;
    };
  };
  programs.nixvim.keymaps = [
    {
      action = "<CMD>Oil<CR>";
      options.desc = "Open Oil File Manager";
      key = "<leader>fm";
    }
  ];
}
