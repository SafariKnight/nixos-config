{ pkgs, config, ... }:
{

  home.shellAliases = {
    v = ''fd -H --type f --print0 --exclude .git | fzf-tmux -p -w 85  --read0 --print0 --preview "bat --color=always --style=numbers {}" | xargs -r -0 nvim'';
    ls = "eza --group-directories-first";
    ovim = "NVIM_APPNAME=ovim nvim";
    gdvim = "nvim --listen 127.0.0.1:55432";
    rt = "trash-put";
    cat = "bat";
    grep = "rg";
    find = "fd";
  };
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      bind \cz 'fg'
    '';
    # shellInitLast = ''fastfetch''; # hell yeah
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
