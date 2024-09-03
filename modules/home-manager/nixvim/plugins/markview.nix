{ ... }:
{
  programs.nixvim.plugins = {
    markview = {
      enable = true;
      settings = {
        mode = [
          "n"
          "i"
          "no"
          "c"
        ];
        hybrid_modes = [ "i" ];
        callback.on_enable = ''
          function(_, win)
            vim.wo[win].conceallevel = 2
            vim.wo[win].concealcursor = "nc"
          end
        '';
      };
    };
  };
}
