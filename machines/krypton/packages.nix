{ pkgs, ... }:
{
  programs.gpu-screen-recorder.enable = true;
  programs.fish.enable = true;
  programs.kdeconnect.enable = true;

  environment.systemPackages = with pkgs; [
    vivaldi
    ungoogled-chromium
    vscode
    gpu-screen-recorder
    anydesk
    rustdesk
    gpu-screen-recorder-gtk
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
    trash-cli
    bat
    nixfmt-rfc-style
    tree
    pavucontrol
    obs-studio
    libnotify
    kdePackages.ark
    qalculate-qt
    # libreoffice
    libqalculate
    ghostty
    usbutils
    dwarfs
    bubblewrap
    fuse-overlayfs
    fuse
    python313
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
