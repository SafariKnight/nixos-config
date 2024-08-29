{
  pkgs,
  inputs,
  outputs,
  userName,
  ...
}:

{
  imports = [
    ./../../modules/nixos
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [ "amdgpu" ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "kareem-nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Africa/Cairo";
  i18n.defaultLocale = "en_US.UTF-8";

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    wget
    git
    wl-clipboard
    wlogout
    wl-color-picker
    ripgrep
    fd
    fzf
    eza
    trash-cli
    bat
    nixfmt-rfc-style
    yazi
    tree
  ];

  fonts.packages = with pkgs; [
    fira
    inter
    noto-fonts
    jetbrains-mono
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];

  programs.hyprland.enable = true;
  programs.fish.enable = true;

  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
    packages = with pkgs; [
      vesktop
    ];
  };

  ### Mount Partions ###
  boot.supportedFilesystems = [ "ntfs" ];

  swapDevices = [ { device = "/dev/disk/by-label/Swap"; } ];
}
