#!/usr/bin/env bash

set -e

echo "Starting Rebuild..."
nixfmt **/

FLAKE_NAME="desktop"
OPERATION="switch"


while getopts 'o:f:' flag; do
  case "${flag}" in
    o) OPERATION=${OPTARG} ;;
    f) FLAKE_NAME=${OPTARG} ;;
  esac
done

nh os $OPERATION $(pwd) -H $FLAKE_NAME -a

notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
