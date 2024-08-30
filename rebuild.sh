FLAKE_NAME="desktop"
OPERATION="switch"
ENABLE_TRACE=false

while getopts 'o:f:t' flag; do
  case "${flag}" in
    o) OPERATION=${OPTARG} ;;
    f) FLAKE_NAME=${OPTARG} ;;
    t) ENABLE_TRACE=true ;;
  esac
done

COMMAND="sudo nixos-rebuild $OPERATION --flake $(pwd)#$FLAKE_NAME --option eval-cache false"

if [ $ENABLE_TRACE == true ]; then
  COMMAND="$COMMAND --show-trace"
fi
eval $COMMAND
