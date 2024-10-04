{pkgs, ...}: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        # frame_color = "#89b4fa";
        # separator_color= "frame";
        # font = "Inter 13";
        width = "(300, 1920)";
        idle_threshold = "5000ms";
      };

      # urgency_low = {
      #   background = "#1e1e2e";
      #   foreground = "#cdd6f4";
      # };
      #
      # urgency_normal = {
      #   background = "#1e1e2e";
      #   foreground = "#cdd6f4";
      # };
      #
      # urgency_critical = {
      #   background = "#1e1e2e";
      #   foreground = "#cdd6f4";
      #   frame_color = "#fab387";
      # };
    };
  };
}
