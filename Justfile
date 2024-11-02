default:
  @just --list

k:
  @just rebuild krypton

kup:
  @just update krypton

ktest:
  @just test krypton

home:
  echo "Starting Home Reconfiguration..."
  nix fmt

  nh home switch

  notify-send -e "Home Manager Switched OK!" --icon=software-update-available


test FLAKE_NAME:
  echo "Starting Rebuild..."
  nix fmt

  nh os test $(pwd) -H {{FLAKE_NAME}}

  notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available

rebuild FLAKE_NAME:
  echo "Starting Rebuild..."
  nix fmt

  nh os build $(pwd) -H {{FLAKE_NAME}}
  nh os switch $(pwd) -H {{FLAKE_NAME}}

  notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available

update FLAKE_NAME:
  echo "Starting Update..."
  nix fmt

  nix flake update
  notify-send -e "Flake Update OK!" --icon=software-update-available

  nixos-rebuild build --flake .#{{FLAKE_NAME}}
  notify-send -e "NixOS Build OK!" --icon=software-update-available

  sudo nixos-rebuild switch --flake .#{{FLAKE_NAME}}
  notify-send -e "NixOS Update FINISHED!" --icon=software-update-available
