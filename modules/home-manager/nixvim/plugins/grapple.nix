{pkgs, ...}: {
  programs.nixvim.extraPlugins = [pkgs.vimPlugins.grapple-nvim];
  programs.nixvim.extraConfigLua = ''
    require("grapple").setup({
      scope = "cwd",
      icons = true,
      status = true,
    })
  '';
  programs.nixvim.keymaps = [
    {
      action = "<CMD>Grapple toggle<CR>";
      options.desc = "Tag a file";
      key = "<A-a>";
    }
    {
      action = "<CMD>Grapple toggle_tags<CR>";
      options.desc = "Toggle tags menu";
      key = "<A-u>";
    }
    {
      action = "<CMD>Grapple select index=1<CR>";
      options.desc = "Grapple to first tag";
      key = "<A-n>";
    }
    {
      action = "<CMD>Grapple select index=2<CR>";
      options.desc = "Grapple to second tag";
      key = "<A-e>";
    }
    {
      action = "<CMD>Grapple select index=3<CR>";
      options.desc = "Grapple to third tag";
      key = "<A-i>";
    }
    {
      action = "<CMD>Grapple select index=4<CR>";
      options.desc = "Grapple to forth tag";
      key = "<A-o>";
    }
  ];
}
