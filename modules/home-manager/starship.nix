{ ... }:
{
  programs.starship = {
    enable = true;
    enableTransience = true;
    settings = {
      format = ''
        \[$directory\] $git_branch
        $character
      '';
      character = {
        success_symbol = "[](bold green)";
        error_symbol = "[](bold red)";
        vimcmd_symbol = "[](bold green)";
        vimcmd_replace_one_symbol = "[](bold purple)";
        vimcmd_replace_symbol = "[](bold purple)";
        vimcmd_visual_symbol = "[](bold yellow)";
      };
      directory = {
        truncation_length = 8;
        format = "[$path]($style)[$read_only]($read_only_style)";
        read_only = ": ";
        read_only_style = "red";
      };
      git_branch = {
        format = "\\([$symbol$branch(:$remote_branch)]($style)\\)";
      };
    };
  };
}
