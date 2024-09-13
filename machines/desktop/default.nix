{
  pkgs,
  lib,
  config,
  inputs,
  outputs,
  userName,
  ...
}:

{
  imports = [ ./../../modules/nixos ];

  console = {
    useXkbConfig = true;
    earlySetup = true;
  };

  boot = {
    consoleLogLevel = 0;
    supportedFilesystems = [ "ntfs" ];
    initrd.verbose = false;
    initrd.systemd.enable = true;
    initrd.kernelModules = [ "amdgpu" ];
    plymouth = {
      enable = true;
      extraConfig = ''
        PlymouthTimeout=0
      '';
    };
    kernelPackages = pkgs.linuxPackages_latest;
    blacklistedKernelModules = [ "rtl8xxxu" ];
    kernelParams = [
      "boot.shell_on_fail"
      "i915.fastboot=1"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "quiet"
    ];
    tmp.useTmpfs = true;

    loader = {
      timeout = lib.mkDefault 0;
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        editor = false;
        configurationLimit = 100;
      };
    };
  };

  networking.hostName = "kareem-nixos";
  networking.networkmanager.enable = true;
  networking.networkmanager = {
    # wifi.powersave = 2;
    wifi.powersave = false;
  };

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
    gcc
    fzf
    eza
    btop
    btrfs-progs
    feh
    trash-cli
    bat
    nixfmt-rfc-style
    yazi
    tree
    pavucontrol
    libnotify
    kdePackages.ark
    p7zip
    qalculate-gtk
    libqalculate
    usb-modeswitch
  ];

  fonts.packages = with pkgs; [
    fira
    inter
    noto-fonts
    jetbrains-mono
    roboto
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
    packages = with pkgs; [ vesktop ];
  };

  ### Mount Partions ###
  swapDevices = [ { device = "/dev/disk/by-label/Swap"; } ];

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
      "rw"
      "user"
      "compress-force=zstd"
      "noatime"
    ];
  };

  fileSystems."/mnt/important" = {
    label = "HDD";
    device = "/dev/disk/by-uuid/4916caf0-5be2-4187-bdd5-722a13a19fa6";
    fsType = "btrfs";
    options = [
      "subvol=important"
      "rw"
      "user"
      "compress-force=zstd"
      "noatime"
    ];
  };
  services.snapper = {
    persistentTimer = true;
    snapshotInterval = "2h";
    configs = {
      root = {
        # why does it complain if this isn't named root
        SUBVOLUME = "/mnt/important";
        ALLOW_USERS = [ "${userName}" ];
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
      "rw"
      "user"
      "compress-force=zstd"
      "noatime"
    ];
  };
}
