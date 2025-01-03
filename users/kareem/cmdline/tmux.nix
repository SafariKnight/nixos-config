{
  pkgs,
  inputs,
  config,
  ...
}: {
  # stylix.targets.tmux.enable = false;
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
      bind r source-file ~/.config/tmux/tmux.conf
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

      set -g default-shell /etc/profiles/per-user/${config.home.username}/bin/fish


      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      bind \\ select-pane -l
    '';
    plugins = [
      {
        plugin = inputs.minimal-tmux.packages.${pkgs.system}.default;
        extraConfig = ''
          set -g @minimal-tmux-status "bottom"
        '';
      }
      {plugin = pkgs.tmuxPlugins.vim-tmux-navigator;}
    ];
  };
}
