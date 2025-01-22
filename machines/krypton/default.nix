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
  modules.boot.greetd.enable = true;
  modules.boot.greetd.command = "Hyprland";
  modules.boot.greetd.startupUser = mainUser;

  modules.desktop.plasma.enable = true;

  modules.desktop.hyprland.enable = true;
  modules.desktop.hyprland.uwsm = true;

  modules.nix.nh.flakePath = "/home/${mainUser}/nixos-config";

  system.stateVersion = "24.05";

  boot = {
    supportedFilesystems = ["ntfs"];
    kernelPackages = pkgs.linuxPackages_latest;
    blacklistedKernelModules = ["rtl8xxxu"];
  };

  networking.hostName = "krypton";
  networking.networkmanager.enable = true;
  networking.networkmanager = {
    wifi.powersave = false;
  };

  time.timeZone = "Africa/Cairo";
  i18n.defaultLocale = "en_US.UTF-8";

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  hardware.i2c.enable = true;

  # hardware.graphics.extraPackages32 = [
  #   pkgs.driversi686Linux.amdvlk
  # ];

  virtualisation.waydroid.enable = true;

  services.gvfs.enable = true;

  programs.gpu-screen-recorder.enable = true;

  # List packages installed in system profile. To search, run: nh search <package-name>
  environment.systemPackages = with pkgs; [
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    usb-modeswitch
    wget
    git
    scrcpy
    wl-clipboard
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
    # inputs.ghostty.packages.${pkgs.system}.default
    ghostty
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

  fonts.packages = with pkgs; [
    fira
    inter
    noto-fonts
    jetbrains-mono
    roboto
    hack-font
    iosevka
    corefonts
    vistafonts
    nerd-fonts.symbols-only
  ];
  # xdg.portal.enable = true;
  # xdg.portal.extraPortals = with pkgs; [
  #   xdg-desktop-portal-gnome
  #   xdg-desktop-portal-gtk
  # ];

  programs.fish.enable = true;

  users.users.${mainUser} = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "uinput"
      "kvm"
      "libvirt"
    ];
    shell = pkgs.bash;
  };

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.kernelModules = ["v4l2loopback"];
}
