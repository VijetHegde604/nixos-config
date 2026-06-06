{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    (inputs.import-tree ./modules)

  ];

  system.stateVersion = "26.05";
}
