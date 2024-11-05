{
  pkgs,
  lib,
  config,
  inputs,
  outputs,
  userName,
  ...
}: {
  imports = [./../../modules/nixos];
  modules.gaming.enable = true;
  # modules.kanata.enable = true;
  modules.keyd.enable = true;
  modules.greetd.command = "niri-session";

  console = {
    useXkbConfig = true;
    earlySetup = true;
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
    # wifi.powersave = 2;
    wifi.powersave = false;
  };

  time.timeZone = "Africa/Cairo";
  i18n.defaultLocale = "en_US.UTF-8";

  # hardware.graphics.extraPackages = [
  #   pkgs.amdvlk
  # ];
  hardware.i2c.enable = true;

  # To enable Vulkan support for 32-bit applications, also add:
  hardware.graphics.extraPackages32 = [
    pkgs.driversi686Linux.amdvlk
  ];

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
        libsForQt5.xdg-desktop-portal-kde
      ];
    };
  };
  environment.variables.MOZ_ENABLE_WAYLAND = "1";

  # List packages installed in system profile. To search, run: nh search <package-name>
  environment.systemPackages = with pkgs; [
    wget
    git
    wl-clipboard
    wlogout
    wl-color-picker
    ripgrep
    fd
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
    qalculate-gtk
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
  ];
  services.flatpak.enable = true;

  fonts.packages = with pkgs; [
    fira
    inter
    noto-fonts
    jetbrains-mono
    roboto
    # berkeley-mono
    hack-font
    iosevka
    (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
  ];

  programs.hyprland.enable = true;
  # programs.sway.enable = true;
  # programs.sway.package = pkgs.swayfx;
  programs.fish.enable = true;

  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "uinput"
    ];
    shell = pkgs.fish;
    packages = with pkgs; [vesktop];
  };

  ### Mount Partions ###
  swapDevices = [{device = "/dev/disk/by-label/Swap";}];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  fileSystems."/mnt/hdd" = {
    label = "HDD";
    device = "/dev/disk/by-uuid/4916caf0-5be2-4187-bdd5-722a13a19fa6";
    fsType = "btrfs";
    options = [
      "subvol=root"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/mnt/important" = {
    label = "HDD";
    device = "/dev/disk/by-uuid/4916caf0-5be2-4187-bdd5-722a13a19fa6";
    fsType = "btrfs";
    options = [
      "subvol=important"
      "compress=zstd"
      "noatime"
    ];
  };
  services.snapper = {
    persistentTimer = true;
    configs = {
      root = {
        # why does it complain if this isn't named root
        SUBVOLUME = "/mnt/important";
        ALLOW_USERS = ["${userName}"];
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
      };
    };
  };
  fileSystems."/mnt/dbg" = {
    label = "HDD";
    device = "/dev/disk/by-uuid/4916caf0-5be2-4187-bdd5-722a13a19fa6";
    fsType = "btrfs";
    options = [
      "compress=zstd"
      "noatime"
    ];
  };

  boot.extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
  boot.kernelModules = ["v4l2loopback"];
  # services.desktopManager.cosmic.enable = true;
  # services.displayManager.cosmic-greeter.enable = true;
  # modules.greetd.enable = false;
  # services.desktopManager.plasma6.enable = true;
  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;
}
