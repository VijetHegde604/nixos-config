{
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.noctalia.homeModules.default
    inputs.niri-flake.homeModules.niri
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  programs.vicinae = {
    enable = true;
    package = pkgs.vicinae;
    systemd = {
      enable = true;
      autoStart = true;
    };
    extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
      nix
    ];
  };

  programs.noctalia = {
    enable = true;
    settings = {

    };
  };
}
