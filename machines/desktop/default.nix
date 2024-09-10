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
    earlySetup = false;
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
    # kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_latest;
    # extraModulePackages = [ config.boot.kernelPackages.rtl8821cu ];
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

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.greetd}/bin/agreety --cmd ${pkgs.bash}/bin/bash";
        user = "${userName}";
      };
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland > /dev/null";
        user = "${userName}";
      };
    };
  };

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

  fileSystems."/mnt/hdd" = {
    label = "HDD";
    device = "/dev/disk/by-uuid/4916caf0-5be2-4187-bdd5-722a13a19fa6";
    fsType = "btrfs";
    options = [
      # "subvol=@hala-back"
      "rw"
      "user"
      "compress-force=zstd"
      "noatime"
    ];
  };
}
