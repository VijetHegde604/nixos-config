{ inputs, pkgs, ... }:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.danksearch.homeModules.dsearch
    inputs.dms-plugin-registry.modules.default
    inputs.vicinae.homeManagerModules.default
  ];

  services.vicinae = {
    enable = true;
    package = pkgs.vicinae;
    systemd = {
      enable = true;
      autoStart = true;
    };
    extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
      bluetooth
      nix
      power-profile
    ];
  };
  programs.dsearch = {
    enable = true;
  };

  programs.dank-material-shell = {
    enable = true;

    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = false;
    enableClipboardPaste = true;

    systemd = {
      enable = true;
      restartIfChanged = true;
    };
  };

}
