#!/usr/bin/env bash

set -e

echo "Starting Rebuild..."
nix fmt

FLAKE_NAME="krypton"
OPERATION="switch"


while getopts 'f:' flag; do
  case "${flag}" in
    # o) OPERATION=${OPTARG} ;;
    f) FLAKE_NAME=${OPTARG} ;;
  esac
done

nh os build $(pwd) -H $FLAKE_NAME
nh os switch $(pwd) -H $FLAKE_NAME

notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
