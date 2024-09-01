{ pkgs, config, ... }:
{

  home.shellAliases =
    let
      # nvim = "${pkgs.neovim}/bin/nvim";
      nvim = "${config.programs.nixvim.finalPackage}/bin/nvim";
    in
    {
      v = "fd -H --type f --print0 --exclude .git | fzf-tmux -p -w 85  --read0 --print0 --preview \"bat --color=always --style=numbers {}\" | xargs -r -0 nvim";
      # v = "${pkgs.fd}/bin/fd -H --type f --print0 --exclude .git | ${pkgs.fzf}/bin/fzf-tmux -p -w 85  --read0 --print0 --preview \"${pkgs.bat}/bin/bat --color=always --style=numbers {}\" | xargs -r -0 ${nvim}";
      # v = "${pkgs.fd}/bin/fd -H --type f --print0 --exclude .git | ${pkgs.fzf}/bin/fzf-tmux -p -w 85  --read0 --print0 --preview \"${pkgs.bat}/bin/bat --color=always --style=numbers {}\" | xargs -r -0 ${nvim}";
      ls = "${pkgs.eza}/bin/eza --group-directories-first";
      ovim = "NVIM_APPNAME=ovim ${nvim}";
      gdvim = "${nvim} --listen 127.0.0.1:55432";
      rt = "${pkgs.trash-cli}/bin/trash-put";
      cat = "${pkgs.bat}/bin/bat";
      grep = "${pkgs.ripgrep}/bin/rg";
      find = "${pkgs.fd}/bin/fd";
    };
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      bind \cz 'fg'
    '';
    functions = {
      mk = ''
        mkdir $argv
        cd $argv
      '';
    };
  };
  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };
}
