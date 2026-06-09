{ pkgs, inputs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
    inputs.niri-flake.homeModules.niri
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  programs.noctalia-shell = {
    enable = true;
    # this may also be a string or a path to a JSON file.
  };
}
