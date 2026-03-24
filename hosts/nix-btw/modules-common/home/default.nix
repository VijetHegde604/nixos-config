{ ... }:
{
  imports = [
    ./starship.nix
    ./shell.nix
    ./git.nix
    ./fastfetch.nix
    ./packages.nix
    ./dms.nix
    ./niri-binds.nix
    ./ghostty.nix
    ./xdg-user-dirs.nix
    ./create-webapp.nix
    ./zed.nix
  ];
}
