{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    modules.gaming.enable = lib.mkEnableOption "Enable Gaming Things";
  };
  config = lib.mkIf config.modules.gaming.enable {
    modules.nix-ld.enable = lib.mkDefault true;
    programs.steam.enable = true;
    programs.steam.protontricks.enable = true;
    environment.systemPackages = with pkgs; [
      (lutris.override {
        extraPkgs = pkgs:
          with pkgs; [
            dolphin-emu
            dolphin-emu-primehack
            pcsx2
            ppsspp
            duckstation
            bsnes-hd
            ryujinx
            mgba
            flycast
            melonDS
            gamescope
            gamemode
            mangohud
          ];
      })
      wine
      wine64
      winetricks
      appimage-run
      dolphin-emu
      dolphin-emu-primehack
      pcsx2
      ppsspp
      duckstation
      bsnes-hd
      ryujinx
      mgba
      flycast
      melonDS
      # (osu-lazer-bin.overrideAttrs {
      #   # version = "2024.906.2";
      #   src = fetchurl {
      #     url = "https://github.com/ppy/osu/releases/download/2024.906.2/osu.AppImage";
      #     curlOpts = "-L";
      #     # hash = "sha256-zQnR3KwlE1gTWH8f+GDRBsc7Whfn9XpT1D/NLg5TtrU=";
      #   };
      # })
      (retroarch.override {cores = [pkgs.libretro.parallel-n64];})
      libretro.parallel-n64
    ];
  };
}
