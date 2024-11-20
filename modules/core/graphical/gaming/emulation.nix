{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    cemu
    appimage-run
    dolphin-emu
    dolphin-emu-primehack
    gamemode
    pcsx2
    ppsspp
    duckstation
    bsnes-hd
    ryujinx
    mgba
    flycast
    melonDS
    gamescope
    (retroarch.override {
      cores = with pkgs.libretro; [
        parallel-n64
        mgba
      ];
    })
    libretro.parallel-n64
  ];
}
