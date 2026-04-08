{ ... }:
let
  # Point to your raw KDL file (adjust the path if needed)
  niriKdlConfig = builtins.readFile ./overrides.kdl;
in
{
  programs.niri = {
    enable = true;
    config = niriKdlConfig;

    settings = {
      spawn-at-startup = [
        { argv = [ "xdg-user-dirs-update" ]; }
        # Official Noctalia startup method for Niri.
        { argv = [ "noctalia-shell" ]; }
      ];
    };
  };
}
