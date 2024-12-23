{
  pkgs,
  config,
  inputs,
  ...
}: let
  mainUser = "kareem";
in {
  imports = [
    ./mounts.nix
  ];
  services.desktopManager.plasma6.enable = true;
  modules.boot.greetd.enable = true;
  modules.boot.greetd.command = "Hyprland";
  modules.boot.greetd.startupUser = mainUser;

  modules.nix.nh.flakePath = "/home/${mainUser}/nixos-config";

  system.stateVersion = "24.05";

  console = {
    useXkbConfig = true;
  };

  boot = {
    supportedFilesystems = ["ntfs"];
    kernelPackages = pkgs.linuxPackages_latest;
    blacklistedKernelModules = ["rtl8xxxu"];
    tmp.useTmpfs = true;
  };

  networking.hostName = "krypton";
  networking.networkmanager.enable = true;
  networking.networkmanager = {
    wifi.powersave = false;
  };

  time.timeZone = "Africa/Cairo";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware.i2c.enable = true;

  hardware.graphics.extraPackages32 = [
    pkgs.driversi686Linux.amdvlk
  ];

  virtualisation.waydroid.enable = true;

  # List packages installed in system profile. To search, run: nh search <package-name>
  environment.systemPackages = with pkgs; [
    wget
    git
    wl-clipboard
    wlogout
    wl-color-picker
    ripgrep
    fd
    zoom-us
    gcc
    fzf
    eza
    btop
    btrfs-progs
    feh
    kdenlive
    trash-cli
    bat
    nixfmt-rfc-style
    yazi
    tree
    pavucontrol
    obs-studio
    libnotify
    kdePackages.ark
    p7zip
    qalculate-qt
    onlyoffice-desktopeditors
    libreoffice
    libqalculate
    inputs.ghostty.packages.${pkgs.system}.default
    usbutils
    dwarfs
    bubblewrap
    fuse-overlayfs
    fuse
    gopeed
    python313
    input-remapper
    obsidian
  ];
  services.flatpak.enable = true;

  fonts.packages = with pkgs; [
    fira
    inter
    noto-fonts
    jetbrains-mono
    roboto
    hack-font
    iosevka
    nerd-fonts.symbols-only
  ];
  # xdg.portal.enable = true;
  # xdg.portal.extraPortals = with pkgs; [
  #   xdg-desktop-portal-gnome
  #   xdg-desktop-portal-gtk
  # ];

  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = false;

  programs.fish.enable = true;

  users.users.${mainUser} = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "uinput"
    ];
    shell = pkgs.bash;
  };

  ### Mount Partions ###
  swapDevices = [{device = "/dev/disk/by-label/Swap";}];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot.extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
  boot.kernelModules = ["v4l2loopback"];
}
