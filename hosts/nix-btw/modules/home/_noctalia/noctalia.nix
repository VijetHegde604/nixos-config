{ pkgs, inputs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
    inputs.niri-flake.homeModules.niri
  ];

  home.packages = with pkgs; [
    cliphist
    grim
    pavucontrol
    slurp
    wl-clipboard
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  programs.noctalia = {
    enable = true;
    settings = {

    };
  };
}
