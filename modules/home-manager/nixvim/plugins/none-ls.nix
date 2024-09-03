{ ... }:
{
  programs.nixvim.plugins = {
    none-ls = {
      enable = true;
      sources = {
        formatting = {
          stylua.enable = true;
          shfmt.enable = true;
          prettier.enable = true;
          csharpier.enable = true;
          nixfmt.enable = true;
        };
        code_actions = {
          refactoring.enable = true;
        };
      };
    };
  };
}
