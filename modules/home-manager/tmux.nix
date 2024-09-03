{ pkgs, inputs, ... }:
{
  stylix.targets.tmux.enable = false;
  programs.tmux = {
    enable = true;
    prefix = "C-s";
    keyMode = "vi";
    terminal = "xterm-kitty";
    baseIndex = 1;
    newSession = true;
    escapeTime = 1;
    extraConfig = ''

      unbind r
      bind r source-file ~/.tmux.conf
      bind a displayp
      bind | split-window -h
      bind - split-window -v

      set -gq allow-passthrough on

      # Fix colors 0
      # set -sa terminal-feature ",xterm-256color:RGB"
      set-option -sa terminal-features ',xterm-256color:RGB'
      set-option -g default-terminal 'xterm-256color'

      # Undercurl
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0

      # Allow scrolling with the mouse
      set -g mouse on

      # Top Status Bar
      set-option -g status-position bottom

      bind -r C-h run "select-pane -L"
      bind -r C-j run "select-pane -D"
      bind -r C-k run "select-pane -U"
      bind -r C-l run "select-pane -R"
      bind -r C-\ run "select-pane -l"
    '';
    plugins = [
      {
        plugin = inputs.minimal-tmux.packages.${pkgs.system}.default;
        extraConfig = ''
          set -g @minimal-tmux-status "bottom"
        '';
      }
      {
        plugin = pkgs.tmuxPlugins.vim-tmux-navigator;
      }
    ];
  };
}
