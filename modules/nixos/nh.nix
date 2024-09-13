{
  userName,
  lib,
  config,
  ...
}: {
  options = {
    modules.nh.enable = lib.mkEnableOption "Enable Nix Helper";
  };
  config = lib.mkIf config.modules.nh.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/${userName}/nixos-config";
    };
  };
}
