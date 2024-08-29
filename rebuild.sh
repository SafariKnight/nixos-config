sudo nixos-rebuild switch --flake $(pwd)#{$1:-desktop} --option eval-cache false --show-trace $2
