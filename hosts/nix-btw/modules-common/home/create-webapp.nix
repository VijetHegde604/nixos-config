{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "create-webapp";

      runtimeInputs = [
        pkgs.curl
        pkgs.imagemagick
        pkgs.coreutils
      ];

      text = builtins.readFile ./user/create-webapp.sh;
    })
  ];
}
