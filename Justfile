default:
  @just --list

k:
  @just rebuild krypton

home:
  echo "Starting Home Reconfiguration..."
  nix fmt

  nh home switch

  notify-send -e "Home Manager Switched OK!" --icon=software-update-available

rebuild FLAKE_NAME:
  echo "Starting Rebuild..."
  nix fmt

  nh os build $(pwd) -H {{FLAKE_NAME}}
  nh os switch $(pwd) -H {{FLAKE_NAME}}

  notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
