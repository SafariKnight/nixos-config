{ ... }:
{
  programs.nixvim.plugins = {
    oil = {
      enable = true;
    };
  };
  programs.nixvim.keymaps = [
    {
      action = "Oil";
      options.desc = "Open Oil File Manager";
      key = "<leader>fm";
    }
  ];
}
