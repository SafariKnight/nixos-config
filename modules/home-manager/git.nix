{ ... }:
{
  programs.git = {
    enable = true;
    userName = "kareem";
    userEmail = "safariknight2@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
