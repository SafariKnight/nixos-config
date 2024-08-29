FLAKE_NAME=${1:-"desktop"}

sudo nixos-rebuild switch --flake $(pwd)#$FLAKE_NAME --option eval-cache false $2
