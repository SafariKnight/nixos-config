#!/usr/bin/env bash

set -e

# $EDITOR flake.nix

if git diff --quiet; then
    echo "No changes detected, exiting."
    exit 0
fi

nixfmt .
git diff -U0

read -p "Does that look good? (y/N)" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi

echo "Starting Rebuild..."

FLAKE_NAME="desktop"
OPERATION="switch"
ENABLE_TRACE=false
FAST=false


while getopts 'o:f:ta' flag; do
  case "${flag}" in
    o) OPERATION=${OPTARG} ;;
    f) FLAKE_NAME=${OPTARG} ;;
    t) ENABLE_TRACE=true ;;
    a) FAST=true ;;
  esac
done

COMMAND="sudo nixos-rebuild $OPERATION --flake $(pwd)#$FLAKE_NAME --impure --option eval-cache false &>nixos-switch.log || (cat nixos-switch.log | grep --color error && exit 1)"

if [ $ENABLE_TRACE == true ]; then
  COMMAND="$COMMAND --show-trace"
fi
if [ $FAST == true ]; then # does this do anything
  COMMAND="$COMMAND --fast"
fi

eval $COMMAND

# current=$(nixos-rebuild list-generations | rg current)
# notify-send -e "NixOS Git Commit Editing" --icon=software-update-available
# git commit -am "$current"
# git commit --amend # Allow editing of the commit message

notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
