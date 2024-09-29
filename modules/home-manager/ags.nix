{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [inputs.ags.homeManagerModules.default];
  programs.ags = {
    enable = true;

    # null or path, leave as null if you don't want hm to manage the config
    configDir = config.lib.file.mkOutOfStoreSymlink ./../../dotfiles/ags;

    # additional packages to add to gjs's runtime
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };
  home.packages = with pkgs; [
    bun
    dart-sass
  ];
}
