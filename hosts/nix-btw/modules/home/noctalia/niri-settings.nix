{ ... }:
{
  xdg.configFile."niri/overrides.kdl".source = ./overrides.kdl;

  programs.niri = {
    enable = true;
    settings = {
      include = [ "~/.config/niri/overrides.kdl" ];
      spawn-at-startup = [
        { argv = [ "xdg-user-dirs-update" ]; }
        { argv = [ "noctalia-shell" ]; }
      ];
    };
  };
}
