sudo nixos-rebuild switch --flake $(pwd)#$1 --option eval-cache false --show-trace $2
