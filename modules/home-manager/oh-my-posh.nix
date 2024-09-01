{ ... }:
{
  programs.oh-my-posh = {
    enable = true;
    settings = builtins.fromTOML (
      builtins.unsafeDiscardStringContext (builtins.readFile ./oh-my-posh.toml)
    );
  };
}
