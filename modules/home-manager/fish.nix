{ pkgs, ... }:
{
  programs.fish =
    let
      colors = {
        fish_color_normal = "normal";
        fish_color_command = "88c0d0";
        fish_color_quote = "a3be8c";
        fish_color_redirection = "b48ead --bold";
        fish_color_end = "81a1c1";
        fish_color_error = "bf616a";
        fish_color_param = "d8dee9";
        fish_color_comment = "4c566a --italics";
        fish_color_match = "--background=brblue";
        fish_color_selection = "d8dee9 --bold --background=434c5e";
        fish_color_search_match = "--bold --background=434c5e";
        fish_color_history_current = "e5e9f0 --bold";
        fish_color_operator = "81a1c1";
        fish_color_escape = "ebcb8b";
        fish_color_cwd = "5e81ac";
        fish_color_cwd_root = "bf616a";
        fish_color_valid_path = "--underline";
        fish_color_autosuggestion = "4c566a";
        fish_color_user = "a3be8c";
        fish_color_host = "a3be8c";
        fish_color_cancel = "--reverse";
        fish_pager_color_prefix = "normal --bold --underline";
        fish_pager_color_progress = "3b4252 --background=d08770";
        fish_pager_color_completion = "e5e9f0";
        fish_pager_color_description = "ebcb8b --italics";
        fish_pager_color_selected_background = "--background=434c5e";
        fish_pager_color_background = "";
        fish_pager_color_secondary_prefix = "";
        fish_pager_color_selected_completion = "";
        fish_pager_color_secondary_completion = "";
        fish_pager_color_secondary_description = "";
        fish_color_keyword = "";
        fish_pager_color_selected_description = "";
        fish_color_host_remote = "";
        fish_color_option = "";
        fish_pager_color_selected_prefix = "";
        fish_pager_color_secondary_background = "";
      };
      colorscheme = builtins.concatStringsSep "\n" (builtins.attrValues (builtins.mapAttrs (name: value: "set -U ${name} ${value}") colors));
    in
    {
      
      enable = true;
      shellAliases = let
        nvim = "${pkgs.neovim}/bin/nvim";
      in {
        v = "${pkgs.fd}/bin/fd -H --type f --print0 --exclude .git | ${pkgs.fzf}/bin/fzf-tmux -p -w 85  --read0 --print0 --preview \"${pkgs.bat}/bin/bat --color=always --style=numbers {}\" | xargs -r -0 ${nvim}";
        ls = "${pkgs.eza}/bin/eza --group-directories-first";
        ovim = "NVIM_APPNAME=ovim ${nvim}";
        gdvim = "${nvim} --listen 127.0.0.1:55432";
        rt = "${pkgs.trash-cli}/bin/trash-put";
        cat = "${pkgs.bat}/bin/bat";
        grep = "${pkgs.ripgrep}/bin/rg";
        find = "${pkgs.fd}/bin/fd";
      };
      interactiveShellInit = ''
        ${colorscheme}
        set fish_greeting
        bind \cz 'fg'

        function starship_transient_prompt_func
          starship module character
        end
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
