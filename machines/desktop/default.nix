{
  pkgs,
  lib,
  inputs,
  outputs,
  userName,
  ...
}:

{
  imports = [
    ./../../modules/nixos
  ];

  console = {
    useXkbConfig = true;
    earlySetup = false;
  };

  boot = {
    consoleLogLevel = 0;
    supportedFilesystems = [ "ntfs" ];
    initrd.verbose = false;
    initrd.systemd.enable = true;
    plymouth.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "amdgpu" ];
    kernelParams = [
      "amdgpu"
      "quiet"
      "boot.shell_on_fail"
      "i915.fastboot=1"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

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
    pavucontrol
    libnotify
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
    packages = with pkgs; [
      vesktop
    ];
  };

  ### Mount Partions ###
  swapDevices = [ { device = "/dev/disk/by-label/Swap"; } ];
}
