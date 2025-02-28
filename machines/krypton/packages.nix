{ pkgs, ... }:
{
  programs.gpu-screen-recorder.enable = true;
  programs.fish.enable = true;
  programs.kdeconnect.enable = true;

  environment.systemPackages = with pkgs; [
    ungoogled-chromium
    vscode
    gpu-screen-recorder
    anydesk
    rustdesk
    gpu-screen-recorder-gtk
    # usb-modeswitch
    wget
    git
    wl-clipboard
    wl-color-picker
    ripgrep
    fd
    gcc
    fzf
    eza
    parsec-bin
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
    pkgs.devenv
  ];

  fonts.packages = with pkgs; [
    fira
    inter
    noto-fonts
    jetbrains-mono
    adwaita-fonts
    roboto
    hack-font
    iosevka
    corefonts
    vistafonts
    nerd-fonts.symbols-only
  ];
}
