{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Kareem Hisham";
    userEmail = "safariknight2@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
    aliases = {
      l = "log --oneline";
      s = "status -s";
      co = "checkout";
    };
  };
}
